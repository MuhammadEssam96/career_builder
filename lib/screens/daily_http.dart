import 'dart:math';
import 'package:careerbuilder/models/IDs.dart';
import 'package:careerbuilder/models/challenge.dart';
import 'package:careerbuilder/models/questions.dart';
import 'package:careerbuilder/widgets/menu_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:careerbuilder/models/TotalScore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:careerbuilder/widgets/answer_button.dart';
import 'package:careerbuilder/widgets/question_text.dart';
import 'challengeScreen.dart';
import 'package:careerbuilder/services/shared_preferences_service.dart';
import 'package:firebase_database/firebase_database.dart';
//TOD

class DailyHttp extends StatefulWidget {
  final String langName;
  final String skillId;
  final String langScore;
  DailyHttp(this.langName, this.langScore,this.skillId);
  // عايزه اسمع هنا طول الليسته
  final int random = Random().nextInt(10);

  @override
  _DailyHttpState createState() => _DailyHttpState(this.random);
}

class _DailyHttpState extends State<DailyHttp> {
  _DailyHttpState(this.random);
  final int random;
  bool show = false;
  Ids idTime = Ids();
  // عايزة اسيف الليسته بالوقت علشان
 final  dbRef= FirebaseDatabase.instance.reference().child('challenge');
  List<Map<bool, Color>> colorsList = [];
  Map<int, String> questionIdsShown = {};
  var questionData = <Map>[];

  Set<int> answeredIds = Set();
  

  Score sr = Score();
  SharedPreferencesService list = SharedPreferencesService();
  Color fButtonColor = Color(0xffB8686B);
  Color tButtonColor = Color(0xff9BE282);
  Color activeColor = Colors.blue;
  // true function

  final String url =
      'https://career-builder-54d16.firebaseio.com/questions.json';

  final String urlChallenge =
      'https://career-builder-54d16.firebaseio.com/challenge.json';
  List<Question> qlist = [];
  List<String> questionIDsFromFirebase = [];
  var userId = 2;
  @override
  void initState() {
    fetchChallenges();
    super.initState();
    fetchQuestions(questionIDsFromFirebase);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Color(0xff09D8D2),
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.white,
    //   systemNavigationBarIconBrightness: Brightness.dark
    // ));
  }

  fetchChallenges() async {
    try {
      var response = await http.get(urlChallenge);
      if (response.statusCode == 200) {
        var loadedChallenges = jsonDecode(response.body);
        if(loadedChallenges is Map){
           loadedChallenges=loadedChallenges.values;
        
        int timeNow = DateTime.now().millisecondsSinceEpoch;
        if (loadedChallenges._length > 0) {
          
          for (var data in loadedChallenges) {
            var challenge = Challenge(
                id: data['id'],
                userId: data['user_id'],
                questionId: data['question_id'],
                score: data['score'],
                skillId: data['skill_id'],
                timeStamp: data['time_stamp']);

            double timeOfChallenge = double.parse(challenge.timeStamp);
            double difference = timeNow - timeOfChallenge;
            print(timeOfChallenge);
            print(timeNow);
            print(difference);
            int minutes = (difference ~/ 6000).toInt(); // from mili to min
            int hours = (minutes ~/ 60);
            print("difference is $hours hours and ${minutes % 60} minutes");
            
            
            if (hours <24) {// false
              // الاساله معداش عليها 24 ساعه ومش هفتش اساله جديده

            } else {
              // فتش كويسشنز
              questionIDsFromFirebase.add(challenge.questionId);
               fetchQuestions(questionIDsFromFirebase);
              // ومكررش الاساله اللي في الشيرد
            }

            
          } // end for loop
        } else { // لو التشالنج فاضيه هات اسئله جديده 
          fetchQuestions(questionIDsFromFirebase);
        }
        }
      } else { // network not 200
        throw Exception('Failed to load questions');
      }
    } catch (a) { // try
      print(a.toString());
    } finally {
      print('ids from firebase $questionIDsFromFirebase');
    }
  }

  fetchQuestions(List questionIDsToExclude) async {
    try {
      print('inside try');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var loadedQ = jsonDecode(response.body);
        print('after load data');
        var t = 'challenge';
        var testName = widget.langName;
        var lev = widget.langScore;
        var daily = 'daily_challenge';
        for (var data in loadedQ) {
          if (data['type'] == t && data['period'] == daily) {
            if (data['test_name'] == testName) {
              if(questionIDsToExclude.isEmpty){
                qlist.add(Question(
                data['id'],
                data['question'],
                data['answer'],
                data['type'],
                data['test_name'],
                data['level'],
                data['score'],
                data['period'],
              ));
              } else {
                if(questionIDsToExclude.contains(data['id'])){
                  continue;
                } else {
                  qlist.add(Question(
                data['id'],
                data['question'],
                data['answer'],
                data['type'],
                data['test_name'],
                data['level'],
                data['score'],
                data['period'],
                ));
                }
              }
              
            }

            // qlist.forEach((w)=> print('    lang  ${w.test_name}') );

          }
        }
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (a) {
      print(a.toString());
    } finally {
      if (qlist.length != 0) {
        print('setState called');
        setState(() {});
      }
    }
  }

  var qId;
  var myq;
  var qanswer;
  var qScore;

  @override
  Widget build(BuildContext context) {
    int b = random;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dailly Challenge'),
        centerTitle: true,
        backgroundColor: Color(0xff09D8D2),
      ),
      endDrawer: Drawer(
        child: Menu(),
      ),
      body: qlist.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  for (int i = index; i < 2; i++) {
                    if (i == 1) {
                      b == qlist.length - 1 ? b -= 1 : b += 1;
                    }

                    if (colorsList.length < 2) {
                      colorsList.add({true: Colors.white, false: Colors.white});
                    }

                    myq = qlist[b].question;
                    qId = qlist[b].id;
                    qanswer = qlist[b].answer.toLowerCase();
                    qScore = qlist[b].score;


                    // add map to questionData
                    if(questionData.length<2){
                    questionData.add({
                       'questionId':'$qId',
                       'score':'$qScore',
                     });
                        
                    }
                    
                    questionIdsShown[index] = qId;

                    // if (questionIdsShown.length == 2) {
                    //   questionIdsShown[2] =DateTime.now().millisecondsSinceEpoch.toString();
                    //   SharedPreferencesService.qIds.add(questionIdsShown);
                    //   print('this is new list ${SharedPreferencesService.qIds}');
                    // }
                    // print(questionIdsShown);
                    // print('qId $qId question${b}: ${myq}  '
                    //     'answer:  ${qanswer} ');
                  }
                   

                  return Container(
                    margin: EdgeInsets.only(
                        top: 20, bottom: 20, left: 15, right: 15),
                    width: 350,
                    decoration: BoxDecoration(
                        color: Color(0xffE0F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  'Question $qId',
                                  style: TextStyle(
                                    color: Color(0xff44919B),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                )),
                            SizedBox(
                              width: 100,
                            ),
                            //Container 10 points
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff09D8D2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    qScore,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text('points',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //text
                        Container(
                          child: questionText(myq),
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
                                    if (qanswer == 'false') {
                                      sr.increaseDailyScore(qScore);
                                      
                                      // list.saveList();
                                      // list.readList();
                                      print('you got it');
                                      print(sr.score);
                                    } else {
                                      print('plz try again');
                                    }
                                    setState(() {
                                      if (colorsList[index][true] ==
                                          tButtonColor) {
                                        colorsList[index][true] = Colors.white;
                                      }
                                      colorsList[index][false] = fButtonColor;
                                      answeredIds.add(index);
                                      print(' question data $questionData');
                                      print(' time ${DateTime.now()}');

                                      

                                      if (questionIdsShown.length >= 2) {
                                        show = true;
                                        // questionIds.add(DateTime.now().millisecondsSinceEpoch);
                                        // print(questionIds);

                                      }
                                    });
                                  }),
                              SizedBox(
                                width: 30,
                              ),
                              answerButton(
                                  buttonColor: colorsList[index][true],
                                  buttonText: 'True',
                                  buttonOnpressed: () {
                                    if (qanswer == 'true') {
                                      sr.increaseDailyScore(qScore);
                                      // list.saveList();
                                      // list.readList();

                                      print('you got it');
                                      print(sr.score);
                                    } else {
                                      print('plz try again');
                                    }
                                    setState(() {
                                      if (colorsList[index][false] ==
                                          fButtonColor) {
                                        colorsList[index][false] = Colors.white;
                                      }
                                      colorsList[index][true] = tButtonColor;
                                      answeredIds.add(index);
                                      print(' question data $questionData');
                                      
                                      if (questionIdsShown.length >= 2) {
                                        show = true;
                                        
                                        // questionIds.add(DateTime.now().millisecondsSinceEpoch);
                                        // print(questionIds);
                                      }
                                      print(answeredIds);
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: answeredIds.length == 2
          ? FloatingActionButton.extended( 
              onPressed: () {
                // if 
                // if(questionData.length!=2){
                // pop message you have to answer the tow q.
                // print('you have to answer all questions');
                // }else{
                  // send to fire
                  dbRef.push().set({
                   'id': '1',
                   'question_id':'${questionData[0]['questionId']}',
                   'score':'${questionData[0]['score']}',
                   'skill_id':'${widget.skillId}',
                   'time_stamp':'${DateTime.now().toUtc().millisecondsSinceEpoch}',
                   'user_id':'2'
                  });

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ChallengeScreen();
                  },
                ));
                // } 
              },
              label: Text('Submmit'),
              icon: Icon(Icons.thumb_up),
              backgroundColor: Color(0xff09D8D2),
            ): Container(),
    );
  }
}

//qlist.length==0?Center(child: CircularProgressIndicator(),):
