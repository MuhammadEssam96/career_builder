import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumber with ChangeNotifier {
  static int _randomNumber;
  int get randomNumber => _randomNumber ?? 0;

  int _maxNumber = 10;

  RandomNumber(){
    _randomNumber = Random().nextInt(_maxNumber);
  }
  
  void reduceMaxNumber(List questionIDsFromChallenges){
    if(questionIDsFromChallenges.isEmpty || questionIDsFromChallenges == null) return;//return nothing
    print('inside reduce');
    int listLength = questionIDsFromChallenges.length;
    if(listLength >= 10) return;
    _maxNumber -= listLength;
    //في مشكله هنا  بيقوله انت خلصت كل الاساله واصلا مفيش في الدابيز غير تلاته بس
    _randomNumber = Random().nextInt(_maxNumber);
    notifyListeners();
  }

}