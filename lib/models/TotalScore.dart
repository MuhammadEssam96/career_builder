import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Score with ChangeNotifier {
  static int _totalScore;
  get score => dailyScore + weeklyScore;

  static int _dailyScore;
  get dailyScore => _dailyScore ?? 0;

  static int _weeklyScore;
  get weeklyScore => _weeklyScore ?? 0;

//const not accept future so we use then
  Score() {
    if (_totalScore == null || _totalScore == 0) {
      //read
      SharedPreferences.getInstance().then((prefs) {
        readTotalScoreFromShared(prefs);
      });
    }

    if (_dailyScore == null || _dailyScore == 0) {
      //read
      SharedPreferences.getInstance().then((prefs) {
        readDailyScoreFromShared(prefs);
      });
    }

    if (_weeklyScore == null || _weeklyScore == 0) {
      //read
      SharedPreferences.getInstance().then((prefs) {
        readWeeklyScoreFromShared(prefs);
      });
    }
  }
  // totalScore functions
  readTotalScoreFromShared(SharedPreferences prefs) {
    int newScore = prefs.getInt('score') ?? 0;
    setTotalScore(newScore);
  }

  setTotalScore(int newScore) {
    _totalScore = newScore;
    print('set called');
    saveTotalScoreToShared(newScore);
  }

  saveTotalScoreToShared(int newScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', newScore);
    notifyListeners();
  }

  increaseTotalScore(dynamic qScore) {
    int convertedScore = int.parse(qScore);
    int newScore = _totalScore + convertedScore;
    setTotalScore(newScore);
  }

  // dailyScore functions
  readDailyScoreFromShared(SharedPreferences prefs) {
    int newScore = prefs.getInt('daily_score') ?? 0;
    setDailyScore(newScore);
  }

  setDailyScore(int newScore) {
    _dailyScore = newScore;
    saveDailyScoreToShared(newScore);
  }

  saveDailyScoreToShared(int newScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('daily_score', newScore);
    notifyListeners();
  }

  increaseDailyScore(dynamic qScore) {
    int convertedScore = int.parse(qScore);
    int newScore = _dailyScore + convertedScore;
    setDailyScore(newScore);
  }

  // weeklyScore functions
  readWeeklyScoreFromShared(SharedPreferences prefs) {
    int newScore = prefs.getInt('weekly_score') ?? 0;
    setWeeklyScore(newScore);
  }

  setWeeklyScore(int newScore) {
    _weeklyScore = newScore;
    saveWeeklyScoreToShared(newScore);
  }

  saveWeeklyScoreToShared(int newScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('weekly_score', newScore);
    notifyListeners();
  }

  increaseWeeklyScore(dynamic qScore) {
    int convertedScore = int.parse(qScore);
    int newScore = _weeklyScore + convertedScore;
    setWeeklyScore(newScore);
  }
}
