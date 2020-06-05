import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyScore with ChangeNotifier {
  static int _dailyScore; // =newScore

//get daily
  get getDailyScore => _dailyScore;

  DailyScore() {
    if (_dailyScore == 0 || _dailyScore == null) {
      SharedPreferences.getInstance().then((prefs) {
        print('read daily called');
        readDaily(prefs);
        print('read daily finished');
      });
    }
  }

//read daily
  readDaily(SharedPreferences prefs) async {
    int newDailyScore = prefs.getInt('dailyScore') ?? 0;
    print('read Daily score called');
    setDaily(newDailyScore);
    print('read Daily score finished');
  }

//increase
  increaseDailyScore(qScore) {
    int convertedScore = int.parse(qScore);
    int totalDailyScore = _dailyScore + convertedScore;
    print('set Daily score called');
    setDaily(totalDailyScore);
    print('set Daily score finished');
  }

//set daily
  setDaily(int newDailyScore) {
    _dailyScore = newDailyScore;
    saveDaily(newDailyScore);
  }

//save daily
  saveDaily(int newDailyScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('dailyScore', newDailyScore);
    notifyListeners();
  }
}
