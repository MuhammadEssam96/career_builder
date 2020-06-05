import 'package:careerbuilder/widgets/level_points.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OldSkills extends StatefulWidget {
  OldSkills({ @required this.style, });
  final TextStyle style;

  @override
  _OldSkillsState createState() => _OldSkillsState();
}

class _OldSkillsState extends State<OldSkills> {
  // final style = TextStyle(color: Colors.black45);
  final List oldSkills = [];
  final List skilldata = [];
  final dbref = FirebaseDatabase.instance.reference().child('user_skills');
  final dbRef2 = FirebaseDatabase.instance.reference().child('skills');
  final Color activeLevel=Color(0xff8CDBD8);
  final Color inactiveLevel=Colors.grey;
  

  fetchInpro() async {
    dbref.orderByChild('user_id').equalTo('2').once().then((snapshot) {
      if (snapshot.value != null) {
        //TODO اشوف حتة النل دي هو كده كده في داتا 
        var response = snapshot.value.values;
        for (int i = 0; i < response.length; i++) {
          if (response.elementAt(i)['status'] == 'old') {
            var skillId = response.elementAt(i)['skill_id'];
            oldSkills.add(response.elementAt(i));
            fetchSkills(skillId);
          }
        }
        if(oldSkills.isEmpty){
          skilldata.add({
            'langname': 'no old skills yet',
            'level': '0'
          });
          setState(() {});
        }
        print('old $oldSkills');
      } else {
        skilldata.add({
          'langname': 'no new skills yet',
          'level': '0'
        });
        setState(() {
          
        });
      }
    });
  }

  fetchSkills(var skillId) {
    dbRef2.child('$skillId').once().then((snapshot2) {
      var response2 = snapshot2.value;
      if (response2 != null) {
        skilldata.add({
          'langname': '${response2['name']}',
          'level': '${response2['level']}'
        });
        print('skill data $skilldata');
        print('skill data ${skilldata.length}');
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchInpro();
  }

  @override
  Widget build(BuildContext context) {
    int skilllength = skilldata.length;
    double equation = (skilllength*35).toDouble();
    double sizedboxHeight = 50 + equation ;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //skills text
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'OLD SKILLS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffA2E8E8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                FontAwesomeIcons.award,
                size: 35,
              ),
            ),
          ],
        ),
        //vertical
        Container(
          margin: EdgeInsets.only(top: 3),
          width: MediaQuery.of(context).size.width - 60,
          height: 2,
          color: Color(0xff8CDBD8)
        ),
        SizedBox(
          height: sizedboxHeight,
          child: skilldata.isNotEmpty ? ListView.builder(
            itemCount: skilldata.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var level=skilldata[index]['level'];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        '${skilldata[index]['langname']}',
                        style: widget.style,
                      ),
                    ),
                  ),
                  oldSkills.isNotEmpty? Row(
                    children: <Widget>[
                      level=='1'||level=='2'||level=='3'?
                      LevelPoints(containerColor:activeLevel)
                      :
                      LevelPoints(containerColor:inactiveLevel),//level 1 2 3
                      SizedBox(width: 1),
                      level=='2'||level=='3'?
                      LevelPoints(containerColor:activeLevel)
                      :
                      LevelPoints(containerColor:inactiveLevel),//level 2 3
                      SizedBox(width: 1),
                      level=='3'?
                      LevelPoints(containerColor:activeLevel)
                      :
                      LevelPoints(containerColor:inactiveLevel),//level 3
                    ],
                  ):Container(),
                ],
              );
            }
          )
          : Center(
               child: CircularProgressIndicator(),
          )
        ),
      ],
    );
  }
}