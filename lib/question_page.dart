
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'constants.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:page_transition/page_transition.dart';
import 'results_page.dart';
import 'question.dart';
bool attempt=false;
//_QuestionPageState _globalState = new _QuestionPageState();
class QuestionPage extends StatefulWidget {
  final String categoryName;
  final int question_no;
  final List<Question>  questionBank;
  final int score;

  QuestionPage({Key key, @required this.categoryName, @required this.question_no,@required this.questionBank,@required this.score}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

//final String categoryName;
class _QuestionPageState extends State<QuestionPage>with SingleTickerProviderStateMixin {
  bool abc=false;
  bool attempted=true;
  AnimationController controller;
  void initState(){
    super.initState();
    controller=AnimationController(
      duration: Duration(seconds:1),
      vsync: this,
    );
    controller.addListener(() {
     // print(controller.value);
    });
    abc=false;
    //_QuestionPageState createState() => _globalState;
  }
  _updateMyTitle(bool ab) {
    setState(() {
      abc = ab;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Center(
            child: Text(
          widget.categoryName,
          style: appbarstyle.copyWith(
            fontSize: 30,
            letterSpacing: 1
          ),
        )),
        backgroundColor: const Color(0xff5D26C1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          CupertinoButton(
            onPressed: () {
              if(widget.question_no==9){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ResultPage(score: widget.score,)));
              }
              else{
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: QuestionPage(categoryName: widget.categoryName,question_no: widget.question_no+1,questionBank: widget.questionBank,score: widget.score,)));
              }
            },
            child: Text(
              'skip',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ], //const Color(0xff59C173)
      ),
      body: Container(
          child: SafeArea(
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
                    height: (MediaQuery.of(context).size.height * 0.46),
                  ),
                  Positioned(
                    top: -MediaQuery.of(context).size.height * 0.07,
                    left: -150,
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
                                ((MediaQuery.of(context).size.width + 300) *
                                    0.5)),
                            bottomLeft: Radius.circular(
                                ((MediaQuery.of(context).size.width + 300) *
                                    0.5)),
                          ),
                        ),
                        height: 340,
                        width: MediaQuery.of(context).size.width + 300,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Question ' + (widget.question_no+1).toString() + ' of 10',
                            style:
                                normal.copyWith(color: Colors.cyanAccent[700]),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            widget.questionBank[widget.question_no].text,
                            style: normal.copyWith(fontSize: 22.5),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.27,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CircleAvatar(
                        radius: 62,
                        backgroundColor: const Color(0xff59C173),
                        child: CircularCountDownTimer(
                          duration:(widget.categoryName=="PUZZLE")?20:15,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          fillColor: Colors.red[700],
                          strokeWidth: 10.0,
                          textStyle: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          isReverse: true,
                          isTimerTextShown: true,
                          onComplete: () {
                            setState(() {
                              attempted=false;
                            });

                            controller.forward();
                            controller.addStatusListener((status) {
                              if(status==AnimationStatus.completed){

                                if(widget.question_no==9){
                                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ResultPage(score: widget.score,)));
                                }
                                else{
                                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: QuestionPage(categoryName: widget.categoryName,question_no: widget.question_no+1,questionBank: widget.questionBank,score: widget.score,)));
                                }
                              }
                            });



                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    options_button(
                      offset: Duration(milliseconds: 0),
                      option_no: 'a',
                      option_title: widget.questionBank[widget.question_no].optiona,
                      category: widget.categoryName,
                      q_no: widget.question_no,
                      questionBank: widget.questionBank,
                      score: widget.score,
                      attempted: attempted,
                      parentAction: _updateMyTitle,
                    ),
                    options_button(
                      offset: Duration(milliseconds: 150),
                      option_no: 'b',
                      option_title: widget.questionBank[widget.question_no].optionb,
                      category: widget.categoryName,
                      q_no: widget.question_no,
                      questionBank: widget.questionBank,
                      score: widget.score,
                      attempted: attempted,
                      parentAction: _updateMyTitle,
                    ),
                    options_button(
                      offset: Duration(milliseconds: 300),
                      option_no: 'c',
                      option_title: widget.questionBank[widget.question_no].optionc,
                      category: widget.categoryName,
                      q_no: widget.question_no,
                      questionBank: widget.questionBank,
                      score: widget.score,
                      attempted: attempted,
                      parentAction: _updateMyTitle,
                    ),
                    options_button(
                      offset: Duration(milliseconds: 450),
                      option_no: 'd',
                      option_title: widget.questionBank[widget.question_no].optiond,
                      category: widget.categoryName,
                      q_no: widget.question_no,
                      questionBank: widget.questionBank,
                      score: widget.score,
                      attempted: attempted,
                      parentAction: _updateMyTitle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class options_button extends StatefulWidget {
  const options_button(
      {this.offset, this.option_no, this.option_title, this.category,this.q_no,this.questionBank,this.score,this.attempted,this.parentAction});
  final Duration offset;
  final int q_no;
  final String option_no;
  final String option_title;
  final String category;
  final int score;
  final List<Question>  questionBank;
  final bool attempted;
  final ValueChanged<bool> parentAction;
  @override
  _options_buttonState createState() => _options_buttonState();
}

class _options_buttonState extends State<options_button> with SingleTickerProviderStateMixin{
  Color _bcolor=Colors.white;
  Color _tcolor=Color(0xffa17fe0);
  //String text=option_no;
  AnimationController controller;
  void initState(){
    super.initState();
    controller=AnimationController(
      duration: Duration(milliseconds:600),
      vsync: this,
    );
    controller.addListener(() {
      //print(controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: SlideInLeft(
        preferences: AnimationPreferences(
          duration: Duration(milliseconds: 500),
          offset: widget.offset,
        ),
        child: RaisedButton(
          elevation: 6,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          disabledElevation: 6,
          disabledColor:(widget.attempted)?((attempt && (widget.questionBank[widget.q_no].answer==widget.option_no))?Colors.green:_bcolor):((widget.questionBank[widget.q_no].answer==widget.option_no)?Colors.green:_bcolor) ,
          color:  (widget.attempted)?_bcolor:((widget.questionBank[widget.q_no].answer==widget.option_no)?Colors.green:_bcolor),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
              side: BorderSide(
                width: 1,
                color: Colors.lightBlueAccent,
              ),
          ),
          onPressed:(!attempt)? () {

            int ns=widget.score;
            setState(() {
              attempt=true;
            });
            widget.parentAction(true);
            if(widget.questionBank[widget.q_no].answer==widget.option_no){
              setState(() {
                _bcolor=Colors.green;
                _tcolor=Colors.white;
               // _bordercol=Colors.green;
              });
              ns++;}
            else{
              setState(() {
                _bcolor=Colors.red;
                _tcolor=Colors.white;
              });
            }
            /*_globalState.setState((){
              _globalState.abc = true;
            });*/

            controller.forward();
            controller.addStatusListener((status) {
              if(status==AnimationStatus.completed){
                widget.parentAction(false);
                setState(() {
                  attempt=false;
                });
                if(widget.q_no==9){
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ResultPage(score:ns,)));
                }
                else{
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: QuestionPage(categoryName: widget.category,question_no: widget.q_no+1,questionBank: widget.questionBank,score: ns,)));
                }
              }
            });


          }:null,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5,5,15,5),
                    padding:EdgeInsets.symmetric(horizontal: 19, vertical: 12),
                      decoration: BoxDecoration(
                      color:  (widget.attempted)?((attempt && (widget.questionBank[widget.q_no].answer==widget.option_no))?Colors.white:_tcolor):((widget.questionBank[widget.q_no].answer==widget.option_no)?Colors.white:_tcolor),
                        borderRadius: BorderRadius.all(Radius.circular(
                              (100)),

                        ),
                    ),
                    child: Text(
                      widget.option_no,
                      style: optionNostyle.copyWith(color: (widget.attempted)?((attempt && (widget.questionBank[widget.q_no].answer==widget.option_no))?Colors.green:_bcolor):((widget.questionBank[widget.q_no].answer==widget.option_no)?Colors.green:_bcolor),),
                    ),
                  ),
                  Text(
                    widget.option_title,
                    style: optionstyle.copyWith(color: (widget.attempted)?((attempt && (widget.questionBank[widget.q_no].answer==widget.option_no))?Colors.white:_tcolor):((widget.questionBank[widget.q_no].answer==widget.option_no)?Colors.white:_tcolor),),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
