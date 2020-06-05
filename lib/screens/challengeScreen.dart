import 'package:careerbuilder/screens/weekly_list.dart';
import 'package:careerbuilder/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'challengeDailyList.dart';

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffC4EAEB),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xffC4EAEB),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/boy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  // height: 350,
                  // margin: EdgeInsets.only(top:250 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(50.0),
                      topRight: Radius.circular(50.0)
                    ),
                    color: Color(0xffEEEEEE),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //your points
                      Card(
                        child: Container(
                          padding: EdgeInsets.only(bottom:4),
                          // height:MediaQuery.of(context).size.width *0.2,
                          width:MediaQuery.of(context).size.width - 150,
                          child: Column(
                            children: <Widget>[
//                        text
                              Container(
                                child: Text(
                                  'Your Points',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
//                        points
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
//                                  padding: EdgeInsets.only(),
                                    child:Icon(FontAwesomeIcons.award,
                                      size: 40,
                                      color: Color(0xff09D8D2),
                                    )
                                  ),
                                  SizedBox(width: 10,),
                                  Consumer<SharedPreferencesService>(
                                    builder: (context, _score, _) {
                                      return Text(
                                        '${_score.score}',
                                      // \nDaily Score :${_score.dailyScore}\nWeekly Score: ${_score.weeklyScore} 
                                        style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    'xp',
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          color: Colors.white,
                        ),
                      ),
                      //choose
                      Container(
                        // margin: EdgeInsets.all(15),
                        child: Text(
                          'choose your challenge',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
//                  challenges
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Color(0xff09D8D2),
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(30.0))),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DailyList()));
                              },
                              child: Column(
                                children: <Widget>[
                                  //image
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                        image: AssetImage('assets/education.png'),
                                        fit: BoxFit.contain
                                      ),
                                    ),
                                  ),
//                            text
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15,left: 15),
                                    child: Text(
                                      'Daily',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 40,),
                            RaisedButton(
                              color: Color(0xff09D8D2),
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(30.0))),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Weeklylist()));
                              },
                              child: Column(
                                children: <Widget>[
                                  //image
                                  Container(
                                    height: 120,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      image:DecorationImage(
                                        image: AssetImage('assets/Capture.PNG'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  // text
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      'Weekly',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}