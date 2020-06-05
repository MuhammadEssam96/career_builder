import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AchieveSection extends StatefulWidget {
  @override
  _AchieveSectionState createState() => _AchieveSectionState();
}

class _AchieveSectionState extends State<AchieveSection> {
  final dbRef = FirebaseDatabase.instance.reference().child('users_achievement');
  final dbRef2 = FirebaseDatabase.instance.reference().child('achievement');
  final List achievementsIds = [];
  final List achievementsData = [];

  //fetch from user achievements
  fetchUserAchieve() {
    dbRef.orderByChild('user_id').equalTo('0').once().then((userSnapshot) {
      print('achievement snapshot ${userSnapshot.value}');
      var userResponse = userSnapshot.value;
      if (userSnapshot.value != null) {
        for (var i = 0; i < userResponse.length; i++) {
          achievementsIds.add(userResponse[i]['achievement_id']);
          var achievementId = achievementsIds[i];
          fetchAchievements(achievementId);
        }

        if (achievementsIds.isEmpty) {
          achievementsData.add('No Achievements yet.');
          setState(() {});
        }
        print('achievements list $achievementsIds');
      }
    });
  }

  //fetch from achievements
  fetchAchievements(var achievementId) {
    dbRef2.child('$achievementId').once().then((achievementSnapshot) {
      print('achievement snapshot ${achievementSnapshot.value}');
      achievementsData.add(achievementSnapshot.value['image']);
      setState(() {});
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
            //achieve text
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'ACHIEVEMENT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 3),
          width: MediaQuery.of(context).size.width - 60,
          height: 2,
          color: Color(0xff8CDBD8),
        ),
        achievementsData.isNotEmpty ?
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: achievementsData.length,
            itemBuilder: (context, index) {
              return Container(
                child: Image.network(
                  '${achievementsData[index]}',
                  width: 70,
                ),
              );
            },
          ),
        )
        : Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
