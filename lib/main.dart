import 'package:careerbuilder/models/random_number.dart';
import 'package:careerbuilder/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:careerbuilder/screens/challengeScreen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/challenges_State.dart';
void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SharedPreferencesService()),
        ChangeNotifierProvider(create: (context) => RandomNumber()),
        ChangeNotifierProvider(create: (context)=>ChallengeState()),
      ],
      child: MyApp()
    ),
  );



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(home:ChallengeScreen());
  }
}





