import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:quiz_whiz/constants.dart';
import 'question_page.dart';
import 'question.dart';
import 'dart:math';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  /*void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
  void initState() {
    initializeFlutterFire();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {

    //CollectionReference users = FirebaseFirestore.instance.collection('questions');
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    try{}catch(e){print(e);}

    return Scaffold(

      body:FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
      return Text('something\'s wrong');
    }

    // Once complete, show your application
    if (snapshot.connectionState == ConnectionState.done) {
      return mainPagequiz();
    }

    // Otherwise, show something whilst waiting for initialization to complete
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
          child: Row(
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
                  autoPlay: AnimationPlayStates.Loop,
                   ),
              ),
              Text(
                'Z WHIZ',
                style: appName,
              ),
            ],
          ),
        ),
      ),
    );
  },



      ),


    );
  }

}

class mainPagequiz extends StatefulWidget {

  @override
  _mainPagequizState createState() => _mainPagequizState();
}
bool waiting=false;


String current_cat = 'SPORTS';
List<Color> icon_colors = [
  Colors.yellow,
  const Color(0x00ffffff),
  const Color(0x00ffffff),
  const Color(0x00ffffff),
  const Color(0x00ffffff),
  const Color(0x00ffffff),
];

List<String> category_name = [
  'SPORTS',
  'GEOGRAPHY',
  'FOOD',
  'PUZZLE',
  'TECH',
  'MOVIES'
];

void gotoquiz(BuildContext contxt){
  /*Navigator.push(contxt,
      MaterialPageRoute(builder: (context) {
        return QuestionPage();
      }));*/
  print('heyuueueh');
}



Widget _buildItem(String s, Color col, int i,BuildContext contxt) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: (){
      gotoquiz(contxt);
    },
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(65),
          color: col,
          boxShadow: [
            BoxShadow(
              color: icon_colors[i - 1],
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 4.5,
              offset: Offset(
                0, // Move to right 10  horizontally
                0, // Move to bottom 10 Vertically
              ),
            ),
          ],
        ),
        width: 85,
        padding: EdgeInsets.all(5),
        child: Center(
          child: Transform.rotate(
            angle: 3.14159,
            child: Text(
              s,
              style: menustyle,
            ),
          ),
        ),
      ),
    ),
  );
}

class _mainPagequizState extends State<mainPagequiz> {
  @override
  void initState() {
    setState(() {
      current_cat = 'SPORTS';
      icon_colors.fillRange(
          0, 6, const Color(0x00ffffff));
      icon_colors[0] = Colors.yellowAccent;
    });
    super.initState();
  }

  //final _firestore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Center(
            child: Text(
              'QU?Z WHIZ',
              style: appbarstyle,
            )),
        backgroundColor: const Color(0xff5D26C1), //const Color(0xff59C173)
      ),
      body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: waiting,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.cyanAccent[100],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: (MediaQuery.of(context).size.height * 0.5),
                      ),
                      Positioned(
                        top: -MediaQuery.of(context).size.height * 0.05,
                        left: -65,
                        child: ClipRect(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 2.0), //(x,y)
                                  spreadRadius: 0.1,
                                  blurRadius: 6.0,
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xff5D26C1),
                                  const Color(0xffa17fe0),
                                  // const Color(0xff59C173)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ), //const Color(0xff5D26C1),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                    ((MediaQuery.of(context).size.width+130) * 0.5)),
                                bottomLeft: Radius.circular(
                                    ((MediaQuery.of(context).size.width+130) * 0.5)),
                              ),
                            ),
                            height: 340,
                            width: MediaQuery.of(context).size.width+130,
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.035,
                        child: Image.asset(
                          'images/logo1.png',
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.16,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(285),
                              topRight: Radius.circular(285),
                            ),
                          ),
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                          //width: 160,
                          child: Transform.rotate(
                            angle: 3.14159,
                            child: Container(
                              padding: EdgeInsets.all(0),
                              child: CircleListScrollView(
                                physics: CircleFixedExtentScrollPhysics(),
                                axis: Axis.horizontal,

                                clipToSize: true,
                                onSelectedItemChanged: (int item) {
                                  setState(() {
                                    icon_colors.fillRange(
                                        0, 6, const Color(0x00ffffff));
                                    icon_colors[item] = Colors.yellowAccent;
                                    current_cat = category_name[item];
                                  });
                                },
                                itemExtent: 85,

                                children: [
                                  _buildItem('⚽', Colors.green, 1, context),
                                  _buildItem('🗺', Colors.yellow, 2, context),
                                  _buildItem('🍒', Colors.lightBlueAccent, 3, context),
                                  _buildItem('🧮', Colors.lime, 4, context),
                                  _buildItem('💻', Colors.red, 5, context),
                                  _buildItem('🎬', Colors.orange, 6, context),
                                ], //🍉📟🎵
                                radius: MediaQuery.of(context).size.width * (0.55),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 25),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff59C173),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(2.0, 5.0), //(x,y)
                                    spreadRadius: 0.1,
                                    blurRadius: 10.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20.0),

                              ),
                              child: FlatButton(
                                //elevation: 10,

                                splashColor: const Color(0xff5D26C1),
                                color: Colors.transparent,
                                textColor: Colors.white,
                                onPressed:() async{
                                  setState(() {
                                    waiting=true;
                                  });
                                  int no=0;
                                  List<Question> questionBank=List<Question>();
                                  try{
                                    CollectionReference messages = FirebaseFirestore.instance.collection('questions');
                                    var query=await messages.where('category',isEqualTo: current_cat).get();
                                    for(var m in query.docs){
                                      no++;
                                      questionBank.add(Question(m.get("text"),m.get("optiona"),m.get("optionb"),m.get("optionc"),m.get("optiond"),m.get("correct"),));
                                    }
                                  }
                                  catch(e){print(e);}
                                  setState(() {
                                    waiting=false;
                                  });

                                  if(questionBank.length<10){
                                    Fluttertoast.showToast(
                                        msg: "Please check your internet connection!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else{
                                    setState(() {
                                      waiting=false;
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context,) {
                                          return QuestionPage(categoryName:current_cat,question_no: 0,questionBank: questionBank,score: 0,);
                                        }));
                                  }

                                  },
                                child:
                                Text(current_cat + ' QUIZ', style: buttonStyle.copyWith(fontWeight: FontWeight.w600)),
                              ),
                            )//newQuizButton(text:,onpress: (){}, )
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                            child: newQuizButton(text: 'TAKE RANDOM QUIZ',onpress: ()async{
                              setState(() {
                                waiting=true;
                              });
                              List<Question> questionBank=List<Question>();
                              List<String> nos=List<String>();
                              int i=0;
                              while(i<10){
                                int no = Random().nextInt(59) + 1;
                                if(nos.contains(no.toString())){}
                                else{nos.add(no.toString());i++;}
                              }
                              int no=0;
                              try{
                                CollectionReference messages = FirebaseFirestore.instance.collection('questions');
                                var query=await messages.where('itemID',whereIn: nos).get();
                                for(var m in query.docs){
                                  questionBank.add(Question(m.get("text"),m.get("optiona"),m.get("optionb"),m.get("optionc"),m.get("optiond"),m.get("correct"),));
                                  no++;
                                }
                              }catch(e){print(e);}
                              print(questionBank.length);

                              setState(() {
                                waiting=false;
                              });
                              if(questionBank.length<10){

                                Fluttertoast.showToast(
                                    msg: "Please check your internet connection!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                              }
                              else{
                                setState(() {
                                  waiting=false;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context,) {
                                      return QuestionPage(categoryName:'RANDOM',question_no: 0,questionBank: questionBank,score: 0,);
                                    }));
                              }
                            },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),

      ),
    );

  }
}

class newQuizButton extends StatelessWidget {
  const newQuizButton({
    @required this.text,this.onpress
  });
  final String text;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff59C173),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2.0, 5.0), //(x,y)
            spreadRadius: 0.1,
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),

      ),
      child: FlatButton(
        //elevation: 10,

        splashColor: const Color(0xff5D26C1),
        color: Colors.transparent,
        textColor: Colors.white,
        onPressed:onpress,
        child:
            Text(text, style: buttonStyle),
      ),
    );
  }
}
