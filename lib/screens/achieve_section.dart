import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AchieveSection extends StatefulWidget {
  @override
  _AchieveSectionState createState() => _AchieveSectionState();
}

class _AchieveSectionState extends State<AchieveSection> {

final dbRef=FirebaseDatabase.instance.reference().child('users_achievement');
final dbRef2=FirebaseDatabase.instance.reference().child('achievement');
final List achivementsIds=[];
final List achivementsData=[];
 //fetch from user achievements
  fetchUserAchieve(){
    dbRef.orderByChild('user_id').equalTo('0').once().then((userSnapshot){
    print('achivement snapshot ${userSnapshot.value}');
    var userResponse=userSnapshot.value;
    if(userSnapshot.value!=null){
      for (var i = 0; i < userResponse.length; i++) {
        achivementsIds.add(userResponse[i]['achievement_id']);
        var achiveId=achivementsIds[i];
        fetchAchievements(achiveId);
      }
      if(achivementsIds.isEmpty){
        achivementsData.add('No Achievements yet.');
        setState(() {
          
        });
      }
      print('achivements list $achivementsIds');
    }
    });
  }
  //fetch from achivements
  fetchAchievements(var achiveId){
    dbRef2.child('$achiveId').once().then((achiveSnapshot){
      print('achievement snapshot ${achiveSnapshot.value}');
      achivementsData.add(achiveSnapshot.value['image']);
      setState(() {
        
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserAchieve();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
              FontAwesomeIcons.medal,
              size: 35,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          //sachieve text
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'ACHIEVEMENT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      //vertical
      Container(
          margin: EdgeInsets.only(top: 3),
          width: MediaQuery.of(context).size.width - 60,
          height: 2,
          color: Color(0xff8CDBD8)),
           achivementsData.isNotEmpty?
                SizedBox(height: 200,
                child: ListView.builder(
                itemCount: achivementsData.length,
                itemBuilder: (context,index){
               return Container(
                 
                 child: Image.network('${achivementsData[index]}',width: 70,),);
                },
                            
              ),
           ):Center(child: CircularProgressIndicator()),
    ],);
  }
}


