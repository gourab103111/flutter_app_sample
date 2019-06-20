import 'package:flutter/material.dart';
import 'package:flutter_app/ScreenArguments.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _counter = 0;

class ScreenThree extends StatefulWidget {
  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {

  final TextEditingController _textController = new TextEditingController();

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      _counter = _counter +  int.parse(_textController.text);
      prefs.setInt('counter', _counter);
      //_counter = (prefs.getInt('counter') ?? 0);

    });
  }

  _loadSubtrack() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      _counter = _counter -  int.parse(_textController.text);
      prefs.setInt('counter', _counter);
      //_counter = (prefs.getInt('counter') ?? 0);

    });
  }


  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             Container(

               height: 40,
               margin: EdgeInsets.fromLTRB(50,0,40,10),
               child: TextField(

                 controller: _textController,

               ),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   child: RaisedButton(
                     child: Text('Add',
                     style: TextStyle(
                       color: Colors.white,
                     ),),
                     color: Colors.green,

                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)
                     ),

                     onPressed: (){


                       _loadCounter();




                     },
                   ),
                 ),
               Container(
                 margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                 child: RaisedButton(

                    child: Text('Substract'
                    ,
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.red,
                    onPressed: (){

                      _loadSubtrack();

                    },
            ),
               ),

                 RaisedButton(
                   child: Text('SQL Lite'),
                   onPressed: (){


                     Navigator.pushNamed(context, '/SampleSqlLite');

                   },

                 ),


               ],
             ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( "$_counter",style:TextStyle(
                  fontSize: 70.0)

                ),
              ],
            ),



          ],

        ),

      ),
    );
  }
}

//MaterialPageRoute(builder: (context) => SecondRoute())