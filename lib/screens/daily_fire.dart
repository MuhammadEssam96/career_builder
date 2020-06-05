import 'package:careerbuilder/models/TotalScore.dart';
import 'package:careerbuilder/models/challenges_State.dart';
import 'package:careerbuilder/models/random_number.dart';
import 'package:careerbuilder/services/shared_preferences_service.dart';
import 'package:careerbuilder/widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:careerbuilder/widgets/question_text.dart';
import 'package:careerbuilder/widgets/answer_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'waiting_screen.dart';
import 'package:provider/provider.dart';
// logic
// اول مره هيفتح السكرينه هيروح يشوف في ايديهات في التشالنج ولا لا
// لا يبقي جيب اساله عادي
// ايوه يبقي شوف عدي عليهم 24 ساعة ولالا
// لا يبقي اظهرله كاونت داون
//  هات اساله جديده واستثني الاساله اللي موجوده في التشالنج
// لما يجاوب علي الاساله السكور ميتزودش غير لما يدوس علي ال سبميت
// الداتا تتبعت لما يدوس علي السبميت

class DailyFire extends StatefulWidget {
  final String languageName;
  final String langLevel;
  final String skillId;
  DailyFire(this.languageName, this.langLevel, this.skillId);

  @override
  _DailyFireState createState() => _DailyFireState(this.languageName);
}

class _DailyFireState extends State<DailyFire> {
  _DailyFireState(this.languageName);
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
  ChallengeState dailyState;

  void initState() {
    super.initState();
    future2 = challengeDbRef.orderByChild('user_id').equalTo('1').once();
    future = questionsDbRef.orderByChild('period').equalTo('daily_challenge').once();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (random == null) {
      print('random constractor called');
      random = Provider.of<RandomNumber>(context,listen: false);
    }

    if(dailyState == null){
      dailyState = Provider.of<ChallengeState>(context,listen: false);
    }
    // الفانكشن اللي موجوده في ال init تتعرف هنا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily challenge'),
        centerTitle: true,
        backgroundColor: Color(0xff09D8D2),
      ),
      endDrawer: Menu(),
      body: FutureBuilder(
        future: future2,
        builder: (context, AsyncSnapshot<DataSnapshot> challSnapshot) {
          // print('snapshot ${challSnapshot}');
          // challenge has data  check the time if pass 24h
          if (challSnapshot.hasData) {
            // handeled
            if (challSnapshot.data.value != null) {
              var challengeResponse = challSnapshot.data.value.values;
              for (var i = 0; i < challengeResponse.length; i++) {
                if (challengeResponse.elementAt(i)['type'] == 'daily') {
                  if (challengeResponse.elementAt(i)['skill_id'] == widget.skillId) {
                    print(widget.skillId);
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
            if (challengeData.isNotEmpty) {
              var time = int.parse(challengeData.last['time_stamp']);
              DateTime challengeTime = DateTime.fromMillisecondsSinceEpoch(time);
              DateTime timeNow = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
              var difference = timeNow.difference(challengeTime).inHours;
              print(challengeTime);
              int differenceInt = int.parse(difference.toString());
              int remaining = 24 - difference;
              print(differenceInt);
              if (differenceInt < 24) {
                if (differenceInt == 1) {
                  return Waiting(remaining, 'hour');
                } else {
                  return Waiting(remaining, 'hours');
                }
              }
            }

            return FutureBuilder(
              future: future,
              builder: (context, AsyncSnapshot<DataSnapshot> questionSnapshot) {
                dailyState.setDailyState(0);
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
                    var langname = response.elementAt(i)['test_name'];
                    var langlevel = response.elementAt(i)['level'];

                    if (langname == lang) {
                      print(response.elementAt(i)['test_name']);
                      if (langlevel == widget.langLevel) {
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
                    print(widget.skillId);
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
                    padding: EdgeInsets.only(bottom: 70),
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (BuildContext context, index) {
                        int randomNum = random.randomNumber;
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
                              borderRadius: BorderRadius.all(Radius.circular(30))),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        'Question ${dailyState.getDailyState}',
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
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
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
                                      answerButton(
                                        buttonColor: colorsList[index][false],
                                        buttonText: 'False ',
                                        buttonOnpressed: () {
                                          if (questionAnswer == 'FALSE') {
                                            if (index == 0) {
                                              if (qUserAnswer1.isNotEmpty) {
                                                qUserAnswer1.clear();
                                              }
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
                                            if (index == 0) {
                                              qUserAnswer1.clear();
                                            } else {
                                              qUserAnswer2.clear();
                                            }
                                            print('answer 1$qUserAnswer1');
                                            print('answer 2$qUserAnswer2');
                                            print('plz try again');
                                          }
                                          setState(() {
                                            if (colorsList[index][true] == tButtonColor) {
                                              colorsList[index][true] = Colors.white;
                                            }
                                            colorsList[index][false] = fButtonColor;
                                            answeredIds.add(index);
                                            // print(
                                            //     ' question data $questionData');
                                            // print(' time ${DateTime.now()}');
                                            if (questionIdsShown.length >= 2) {
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
                                      answerButton(
                                        buttonColor: colorsList[index]
                                            [true],
                                        buttonText: 'True',
                                        buttonOnpressed: () {
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
                                            if (questionIdsShown.length >= 2) {
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
      floatingActionButton: answeredIds.length == 2 ? FloatingActionButton.extended(
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
              'type': 'daily',
              'time_stamp': '${DateTime.now().toUtc().millisecondsSinceEpoch}',
            });
            dailyState.setDailyState(1);
            shared.increaseDailyScore(questionScore);
          } else {
            dbRef.push().set({
              'id': '3',
              'question_id': '${qIdes[0]}',
              'score': '',
              'user_id': '1',
              //fixed values
              'skill_id': '${widget.skillId}',
              'type': 'daily',
              'time_stamp':'${DateTime.now().toUtc().millisecondsSinceEpoch}',
            });
            dailyState.setDailyState(1);
          }
          // send question 2 answer
          if (qUserAnswer2.isNotEmpty) {
            // send to fire
            dbRef.push().set({
              'id': '4',
              'question_id': '${qIdes[1]}',
              'score': '$questionScore',
              'user_id': '1',
              //fixed values
              'skill_id': '${widget.skillId}',
              'type': 'daily',
              'time_stamp':'${DateTime.now().toUtc().millisecondsSinceEpoch}',
            });
            dailyState.setDailyState(1);
            shared.increaseDailyScore(questionScore);
            print('sent sccussfully');
          } else {
            dbRef.push().set({
              'id': '5',
              'question_id': '${qIdes[1]}',
              'score': '',
              'user_id': '1',
              //fixed values
              'skill_id': '${widget.skillId}',
              'type': 'daily',
              'time_stamp':'${DateTime.now().toUtc().millisecondsSinceEpoch}',
            });
            dailyState.setDailyState(1);
          }
         Navigator.pop(context);
        },
        label: Text('Submit'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Color(0xff09D8D2),
      ) : Container(),
    );
  }
}