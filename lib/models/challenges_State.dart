import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChallengeState with ChangeNotifier{
  //daily state
  static int _dailyState;
  get getDailyState=>_dailyState ?? 0;

  ChallengeState() {
    if (_dailyState == null || _dailyState == 0) {
      SharedPreferences.getInstance().then((prefs) {
        print('read daily state start');
        readDailyState(prefs);
        print('read daily state finished');
      });
    }
  }

  setDailyState(int dailyNum) {
    print('set daily state start');
    _dailyState = dailyNum;
    print('save daily state start');
    saveDailyState(dailyNum);
  }

  saveDailyState(int dailyNum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('DailyState', dailyNum);
    notifyListeners();
    print('save daily state finished');
  }

  readDailyState(SharedPreferences prefs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt('DailyState');
  }
}
