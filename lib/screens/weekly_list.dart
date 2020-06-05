import 'package:careerbuilder/screens/daily_fire.dart';
import 'package:careerbuilder/screens/weekly_challenge.dart';
import 'package:careerbuilder/widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Weeklylist extends StatelessWidget {
  static var userId = '2';
  final List dailyChallengeLang = [
    'java',
    'c_sharp',
    'php',
    'python',
    'c_plus',
    'javascript',
  ];
  var go = 'go lang';
  var c = 'c++';
  var csharp = 'c#';
  final dbRef = FirebaseDatabase.instance.reference().child("user_skills");
  final dbRef2 = FirebaseDatabase.instance.reference().child('skills');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your list'),
          backgroundColor: Color(0xff09D8D2),
        ),
        endDrawer: Menu(),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/programmer.jpg'),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            child: Center(
                child: FutureBuilder(
                    //deal with user_skills and fetch every record depend on user id=2
                    future:
                        dbRef.orderByChild("user_id").equalTo('$userId').once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      var response;
                      if (snapshot.hasData) {
                        if (snapshot.data.value is List) {
                          // print('  data in user skills ${snapshot.data.value}');
                          response = snapshot.data.value;
                        } else if (snapshot.data.value is Map) {
                          print(
                              '  data in user skills ${snapshot.data.value.values}');
                          response = snapshot.data.value.values;
                        }

                        if(snapshot.data.value==null){
                         return Container(child: Text('no challenges yet',
                         style: TextStyle(
                           fontSize: 20,
                           color: Colors.black54,
                           fontWeight: FontWeight.w700
                           ),),);
                       }
                        return ListView.builder(
                          itemCount: response.length,
                          itemBuilder: (BuildContext context, int index) {
                            var skillId = response.toList()[index]['skill_id'];
                            if (response.toList()[index]['status'] ==
                                'inprogress') {
                              return Container();
                            }
                            // print('skill id $skillId');
                            return FutureBuilder(
                              //deal with skills and fetch lang name and level
                              future: dbRef2.child('$skillId').once(), //0,1,2
                              builder: (context, snapshot2) {
                                if (snapshot2.hasData) {
                                  print(
                                      '  data in skills ${snapshot2.data.value}');
                                  if (dailyChallengeLang
                                      .contains(snapshot2.data.value['name'])) {
                                    String text = snapshot2.data.value['name'];
                                    String level =
                                        snapshot2.data.value['level'];
                                    if (snapshot2.data.value['name'] ==
                                        'go_lang') {
                                      text = go;
                                    } else if (snapshot2.data.value['name'] ==
                                        'c_plus') {
                                      text = c;
                                    } else if (snapshot2.data.value['name'] ==
                                        'c_sharp') {
                                      text = csharp;
                                    }
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(top: 40),
                                            width: 250,
                                            height: 60,
                                            child: RaisedButton(
                                                color: Color(0xFF09D8D2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return WeeklyChallenge(
                                                        text, level, skillId);
                                                  }));
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 15),
                                                    child: Text("$text",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .white)))))
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                                return CircularProgressIndicator();
                              },
                            );
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    })),
          ),
        ));
  }
}
