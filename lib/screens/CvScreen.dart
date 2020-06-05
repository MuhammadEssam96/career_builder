
import 'package:careerbuilder/models/user.dart';
import 'package:careerbuilder/screens/new_skills.dart';
import 'package:careerbuilder/screens/old_skills.dart';
import 'package:careerbuilder/widgets/inpro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'achieve_section.dart';


class CvScreen extends StatefulWidget {
  @override
  _CvScreenState createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
final  style= TextStyle(color: Colors.black54,fontSize: 16);
 User user=User();
 final userDbRef = FirebaseDatabase.instance.reference().child('users');
  final List u=[];

  fetchUser(){
  userDbRef.orderByChild('id').equalTo('0').once().then(( snapshot){
   var userResponse = snapshot.value;
     print('userResponse1 $userResponse');
     if(userResponse!=null){
      u.add({
                 'fName': '${userResponse[0]['first_name']}',
                  'lName': '${userResponse[0]['last_name']}',
                  'job': '${userResponse[0]['job']}',
                  'gender': '${userResponse[0]['gender']}',
                  'age': '${userResponse[0]['age']}',
                  'education': '${userResponse[0]['eduvation']}',
                  'email': '${userResponse[0]['email']}',
                  'phone': '${userResponse[0]['phone']}',
                  'img': '${userResponse[0]['profile_picture']}',
    });
    print('user data $u');
    setState(() {
      
    });
     }
  });
  }
@override
  void initState() {
    super.initState();
    print('start fetching');
    fetchUser();
    print('end fetching');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: u.isNotEmpty ?CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            floating: true,
            pinned: true,
            snap: true,
            backgroundColor: Color(0xffD5FFFD),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        // Circle shape
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.0,
                          color: Color(0xff64BFB8),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 77,
                          backgroundColor: Colors.amber,
                          backgroundImage: NetworkImage('${u[0]['img']}'),
                        ),
                      ),
                    ),
                    //header info
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        u.isNotEmpty ?Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.40,
                            child: Text(
                              'amany mohamed mohamed gharib',
                              style: TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                                  textAlign: TextAlign.center,
                            ),
                          ),
                        ):CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${u[0]['job']}',
                            style: style,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '${u[0]['gender']}',
                                style: style,
                              ),
                              SizedBox(width: 2),
                              Text('|',
                                  style: TextStyle(color: Color(0xff64BFB8))),
                              SizedBox(width: 2),
                              Text(
                                '${u[0]['age']}',
                                style: style,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //contact  section
                      Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffA2E8E8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              FontAwesomeIcons.addressBook,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          //achieve text
                          Container(
                            padding: EdgeInsets.only(top: 20),
//                          margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'CONTACT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
//                          margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'EDUCATION',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //skills icon
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffA2E8E8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              FontAwesomeIcons.university,
                              size: 35,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  //vertical line
                  Container(
                      margin: EdgeInsets.only(top: 3),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 2,
                      color: Color(0xff8CDBD8)),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //contact info
                              Row(
                                
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.email),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16,bottom: 8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.35,
                                      child: Text('${u[0]['email']}',style: style,)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.phone),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('${u[0]['phone']}',style: style,),
                                  ),
                                ],
                              ),


                             SizedBox(height: 30,),


                            // achievements
                            AchieveSection(),
                            SizedBox(height: 30,),
                            //inprogress section
                            Inprog(style: style)
                            ],
                          ),
                        ),
                      ),
                      //horizental line
                      Container(
                          width: 2, height: MediaQuery.of(context).size.height, color: Color(0xff8CDBD8)),
                        // education old & new skills
                      Flexible(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              //education section
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16,left: 16),
                                    child: Container(width: MediaQuery.of(context).size.width*0.38,
                                      child: Text('${u[0]['education']}',
                                      style: style),
                                    ),
                                  ),
                                ],
                              ),
                             SizedBox(height:30),
                             //OLD SKILLS
                            OldSkills(style: style),
                            SizedBox(height: 30,),
                           //NEW SKILLS
                           NewSkills(style: style),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            )
          ]))
        ],
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}

