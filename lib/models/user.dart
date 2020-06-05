import 'package:firebase_database/firebase_database.dart';

class User {
  final String fName;
  final String lName;
  final String job;
  final String gender;
  final String education;
  final String email;
  final String phone;
  final String age;
  final String img;
  final userDbRef = FirebaseDatabase.instance.reference().child('users');
  final List u = [];

  User({
    this.fName,
    this.lName,
    this.job,
    this.gender,
    this.education,
    this.email,
    this.phone,
    this.age,
    this.img
  });

  fetchUser() {
    userDbRef.child('id').equalTo('0').once().then((snapshot) {
      var userResponse = snapshot.value;
      print('userResponse1 $userResponse');
      u.add({
        'fName': '${userResponse['first_name']}',
        'lName': '${userResponse['last_name']}',
        'job': '${userResponse['job']}',
        'gender': '${userResponse['gender']}',
        'age': '${userResponse['age']}',
        'education': '${userResponse['eduvation']}',
        'email': '${userResponse['email']}',
        'phone': '${userResponse['phone']}',
        'img': '${userResponse['profile_picture']}',
      });
    });
  }
}
