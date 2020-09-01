import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'constants.dart';
import 'package:page_transition/page_transition.dart';
import 'homescreen.dart';

class ResultPage extends StatefulWidget {
  final int score;
  ResultPage({Key key, @required this.score}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
          appBar: AppBar(
            elevation: 3,
            title: Center(
                child: Text(
                  'RESULT',
                  style: appbarstyle,
                )),
            backgroundColor: const Color(0xff5D26C1), //const Color(0xff59C173)
          ),
          body: SafeArea(
            child: Container(
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
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                margin: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent[100],
                  borderRadius: BorderRadius.all(Radius.circular((60)),
                  ),
                ),
                child: MyAp(score: widget.score,),
              ),
            ),
          ),
        ));
  }
}
class MyAp extends StatefulWidget {
   int type=0;
  final int score;
  MyAp({Key key, @required this.score}) : super(key: key);

  @override
  _MyApState createState() => _MyApState();
}

class _MyApState extends State<MyAp> {
  ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 700));
    if(widget.score>4){widget.type=1;_controllerCenter.play();}

    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset('images/t'+widget.type.toString()+'.png',
          height: 70,
          width: MediaQuery.of(context).size.width,),

      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /*Container(
            height:MediaQuery.of(context).size.height/2 ,
          ),*/

          Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                emissionFrequency: 1,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 50,
                shouldLoop: false,
                numberOfParticles: 2,

                minimumSize: const Size(5,
                    5),
                maximumSize: const Size(10,
                    10),
                colors: const [
                  Colors.yellowAccent,
                  Colors.lightBlueAccent,
                  Colors.pink,
                  Colors.red,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),

           Align(alignment:Alignment.center,child: Image.asset('images/i'+widget.type.toString()+'.png',
                height: 200,
                //width: MediaQuery.of(context).size.width,
              ),
           ),



        ],
      ),
        SizedBox(height: 10,),
        Column(

        children: <Widget>[
        Text('You scored',style: TextStyle(fontSize: 20,color: Colors.blueGrey,),),
        Text(widget.score.toString()+' / 10',style: TextStyle(fontSize: 60,color:Color(0xff59C173) ,letterSpacing: 2,fontWeight: FontWeight.w900,)),
      ],),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
            side: BorderSide(
              width: 2,
              color: Color(0xffa17fe0),
            ),
          ),
          padding: EdgeInsets.all(15),
          color: Color(0xff5D26C1),
          child:Text('RETAKE QUIZ',style: normal,),onPressed: (){
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: new HomeScreen()));
        },),
        SizedBox(height: 10,),
      ],);
  }
}