// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

// class TotalScore3 with ChangeNotifier {
//   static int _score;
//   int get gscore {
//     return loadScore();
//   }

//   // set gscore(int newScore) {
//   //   return newScore;
//   //   notifyListeners();
//   // }

//   void increaseScore(qScore) {
//     var convertedScore = int.parse(qScore);
//     _score += convertedScore;
//     notifyListeners();
//   }

//   setS() async {
//     final pref = await SharedPreferences.getInstance();
//     pref.setInt('score', _score);
//     notifyListeners();
//   }

//    loadScore() async {
//     final pref = await SharedPreferences.getInstance();
//     gscore = pref.getInt('score') ?? 0;
//     return gscore;
//   }
// }
