import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'homescreen.dart';
import 'constants.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xff5D26C1),
              const Color(0xffa17fe0),
              const Color(0xff59C173),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 1,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'QU',
                    style: appName,
                  ),
                  Tada(
                    child: Text(
                      '?',
                      style: appName,
                    ),
                    preferences: AnimationPreferences(
                        //autoPlay: AnimationPlayStates.Loop,
                        animationStatusListener: (status) {
                      if (status == AnimationStatus.completed) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    }),
                  ),
                  Text(
                    'Z WHIZ',
                    style: appName,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('VIBHUTI PATEL',style: normal.copyWith(letterSpacing: 15,fontWeight:FontWeight.w700,fontSize: 13),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
