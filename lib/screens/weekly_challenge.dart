import 'package:careerbuilder/models/TotalScore.dart';
import 'package:careerbuilder/models/random_number.dart';
import 'package:careerbuilder/services/shared_preferences_service.dart';
import 'package:careerbuilder/widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:careerbuilder/widgets/question_text.dart';
import 'package:careerbuilder/widgets/answer_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'waiting_screen.dart';
import 'package:provider/provider.dart';

class WeeklyChallenge extends StatefulWidget {
  final String languageName;
  final String langLevel;
  final String skillId;

   WeeklyChallenge(this.languageName, this.langLevel, this.skillId);

  @override
  _WeeklyChallengeState createState() => _WeeklyChallengeState(this.languageName);
}

class _WeeklyChallengeState extends State<WeeklyChallenge> {
  _WeeklyChallengeState(this.languageName);

  RandomNumber random;
  final String languageName;
  List<Map<bool, Color>> colorsList = [];
  Map<int, String> questionIdsShown = {};
  Set<int> answeredIds = Set();
  List qIdes = [];
  bool show = false;
  Score sr = Score();
  var questionData = <Map>[];
  final dbRef = FirebaseDatabase.instance.reference().child('challenge');
  SharedPreferencesService shared = SharedPreferencesService();
  Color fButtonColor = Color(0xffB8686B);
  Color tButtonColor = Color(0xff9BE282);
  Color activeColor = Colors.blue;
  List questions = [];
  List challengeData = [];
  List challengeIds = [];
  var qtext;
  final questionsDbRef = FirebaseDatabase.instance.reference().child('questions');
  final challengeDbRef = FirebaseDatabase.instance.reference().child('challenge');
  var questionId;
  var questiontext;
  var questionAnswer;
  var questionScore;
  List qUserAnswer1 = [];
  List qUserAnswer2 = [];
  var future;
  var future2;

  void initState() {
    super.initState();
    future2 = challengeDbRef.orderByChild('user_id').equalTo('1').once();
    future = questionsDbRef.orderByChild('period').equalTo('weekly_challenge').once();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(random==null){
      random = Provider.of<RandomNumber>(context);
    }
    // الفانكشن اللي موجوده في ال init تتعرف هنا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weekly challenge'),
        centerTitle: true,
        backgroundColor: Color(0xff09D8D2),
      ),
      endDrawer: Menu(),
      body: FutureBuilder(
        future: future2,
        builder: (context, AsyncSnapshot<DataSnapshot> challSnapshot) {
          // print('snapshot ${challSnapshot}');

          // challenge has data  check the time if pass 24h
          if (challSnapshot.hasData) {// handeled
            if (challSnapshot.data.value != null) {
              var challengeResponse = challSnapshot.data.value.values;
              for (var i = 0; i < challengeResponse.length; i++) {
                if(challengeResponse.elementAt(i)['type'] =='weekly'){
                  if (challengeResponse.elementAt(i)['skill_id'] == widget.skillId) {
                    challengeData.add({
                      'question_id': '${challengeResponse.elementAt(i)['question_id']}',
                      'time_stamp': '${challengeResponse.elementAt(i)['time_stamp']}',
                      'skill_Id': '${challengeResponse.elementAt(i)['skill_id']}',
                    });
                    challengeIds.add(challengeResponse.elementAt(i)['question_id']);
                  }
                } else {
                  print('no skill id found in challenge');
                  print(widget.skillId);
                }
              }
            }
            Future.delayed(
              Duration(milliseconds: 100),
              () {
                random.reduceMaxNumber(challengeIds);
              }
            );
            print('after reduce in challenge');
            print('challenge Ids $challengeIds');
            // print( ' the skill id for ${widget.languageName}  is ${widget.skillId}');
            // print(challSnapshot.data.value.values);
            // print('${challengeData[0]['time_stamp']}');            //
            if(challengeData.isNotEmpty){
            var time = int.parse(challengeData.last['time_stamp']);
            DateTime challengeTime = DateTime.fromMillisecondsSinceEpoch(time);
            DateTime timeNow = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
            var difference = timeNow.difference(challengeTime).inDays;
            print(challengeTime);
            int differenceInt = int.parse(difference.toString());
            int remaining = 7 - difference;
            print(differenceInt);
            if (differenceInt < 7) {
              if(differenceInt==1){
                return Waiting(remaining,'day');
              } else {
                return Waiting(remaining,'days');
              }
            }
          }
          return FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<DataSnapshot> questionSnapshot) {
              var lang = languageName;
              if (languageName == 'go lang') {
                lang = 'go_lang';
              } else if (languageName == 'c++') {
                lang = 'c_plus';
              }
              // data from fire
              if (questionSnapshot.hasData) {
                var response = questionSnapshot.data.value.values;
                for (int i = 0; i < response.length; i++) {
                  if (response.elementAt(i)['test_name'] == lang) {
                    if (response.elementAt(i)['level'] == widget.langLevel) {
                      if (challengeData.isNotEmpty) {
                        //exclude and fetch
                        if (challengeIds.contains(response.elementAt(i)['id'])) {
                          continue;
                        } else {
                          //  print(' inside else after continue$i');
                          questions.add(response.elementAt(i));
                          // print('questions ${questions[i]['question_id']}');
                        }
                      } else {
                        // fetch questions
                        questions.add(response.elementAt(i));
                        // print(' inside else after we dont have data in challenge');
                      }
                    }
                  } //first if
                } //for
                if (questions.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Text(
                        'You have completed all challenges,waiting for new challenges,thank you.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                //  print('challenge data $challengeData');
                //  print('questions ${questions}');
                // print('before loop $randomNum');
                return Padding(
                  padding: EdgeInsets.only(bottom: 70,top: 50),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, index) {
                      int randomNum =random.randomNumber;
                      if (index == 1) {
                        randomNum == questions.length - 1 ? randomNum -= 1 : randomNum += 1;
                      }
                      print('the random number$randomNum');
                      // print('random in for ${randomNum}');
                      // if(!challengeData.contains(questions[randomNum]['question_id'])){
                      if (questions.isNotEmpty) {
                        questionId = questions[randomNum]['id'];
                        questiontext = questions[randomNum]['question'];
                        questionAnswer = questions[randomNum]['answer'];
                        questionScore = questions[randomNum]['score'];
                        qIdes.insert(index, questions[randomNum]['id']);
                      } else {
                        print('you finish');
                      }
                      // }else{
                      //   return Container(child:Text('you have completed all challenges'));
                      // }
                     // print('$questiontext');
                      if (colorsList.length < 2) {
                        colorsList.add({true: Colors.white, false: Colors.white});
                      }
                      // print('the ides $qIdes');
                      // print(questions);
                      // print('the real answer$questionId $questionAnswer');
                      // print(colorsList);
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffE0F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      'Question ${index + 1}',
                                      style: TextStyle(
                                        color: Color(0xff44919B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    )
                                  ),
                                 //Container 10 points
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xff09D8D2),
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          questionScore,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'points',
                                          style: TextStyle(
                                            color: Colors.white
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: questionText(questiontext),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              //buttons
                              // لما يجاوب علي الاساله المفروض ابعت اسكور السؤالين لاشرف في البروفايل
                              Container(
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //false button
                                    AnswerButton(
                                      buttonColor: colorsList[index][false],
                                      buttonText: 'False ',
                                      buttonOnPressed: () {
                                        if (questionAnswer == 'FALSE') {
                                          if (index == 0) {
                                            if (qUserAnswer1.isNotEmpty) {
                                              qUserAnswer1.clear();
                                            }
                                            qUserAnswer1.insert(index, true);
                                            print('when index = 0 $qUserAnswer1');
                                          }
                                          // sr.increaseDailyScore(questionScore);
                                          print('you got it');
                                          print(sr.score);
                                        } else {
                                          if (index == 0) {
                                            qUserAnswer1.clear();
                                          }
                                          print('answer 1$qUserAnswer1');
                                          print('plz try again');
                                        }
                                        setState(() {
                                          if (colorsList[index][true] == tButtonColor) {
                                            colorsList[index][true] = Colors.white;
                                          }
                                          colorsList[index][false] = fButtonColor;
                                          answeredIds.add(index);
                                          if (questionIdsShown.length >= 1) {
                                            show = true;
                                            // questionIds.add(DateTime.now().millisecondsSinceEpoch);
                                            // print(questionIds);
                                          }
                                        });
                                      }
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    AnswerButton(
                                      buttonColor: colorsList[index][true],
                                      buttonText: 'True',
                                      buttonOnPressed: () {
                                        if (questionAnswer == 'TRUE') {
                                          if (index == 0) {
                                            qUserAnswer1.insert(index, true);
                                            print('when index = 0 $qUserAnswer1');
                                          } else {
                                            qUserAnswer2.insert(0, true);
                                            print('when index = 1 $qUserAnswer2');
                                          }
                                          // sr.increaseDailyScore(questionScore);
                                          print('you got it');
                                          print(sr.score);
                                        } else {
                                          print('answer 1$qUserAnswer1');
                                          print('answer 2$qUserAnswer2');
                                          print('plz try again');
                                        }
                                        setState(() {
                                          if (colorsList[index][false] == fButtonColor) {
                                            colorsList[index][false] = Colors.white;
                                          }
                                          colorsList[index][true] = tButtonColor;
                                          answeredIds.add(index);
                                          // print(
                                          //     ' question data $questionData');
                                         if (questionIdsShown.length >= 1) {
                                           show = true;
                                           // questionIds.add(DateTime.now().millisecondsSinceEpoch);
                                            // print(questionIds);
                                         }
                                          print(answeredIds);
                                        });
                                      }
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
              },
            );
          } else {
            return Center(
              child: Text(
                'Check your internet connection please.',
                style: TextStyle(color: Colors.black45),
              ),
            );
          }
        },
      ),
      floatingActionButton: answeredIds.length == 1 ? FloatingActionButton.extended(
        onPressed: () {
          // send question 1 answer
          if (qUserAnswer1.isNotEmpty) {
            // send to fire
            dbRef.push().set({
              'id': '2',
              'question_id': '${qIdes[0]}',
              'score': '$questionScore',
              'user_id': '1',
              //fixed values
              'skill_id': '${widget.skillId}',
              'type':'weekly',
              'time_stamp':
                  '${DateTime.now().toUtc().millisecondsSinceEpoch}',
            });
            shared.increaseWeeklyScore(questionScore);
          } else {
            dbRef.push().set({
              'id': '3',
              'question_id': '${qIdes[0]}',
              'score': '',
              'user_id': '1',
              //fixed values
              'skill_id': '${widget.skillId}',
              'type':'weekly',
              'time_stamp': '${DateTime.now().toUtc().millisecondsSinceEpoch}',
            });
          }
          Navigator.pop(context);
        },
          label: Text('Submit'),
          icon: Icon(Icons.thumb_up),
          backgroundColor: Color(0xff09D8D2),
        )
      : Container(),
    );
  }
}