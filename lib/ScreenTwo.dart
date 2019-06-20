import 'package:flutter/material.dart';
import 'package:flutter_app/ScreenThree.dart';
import 'package:flutter_app/ScreenArguments.dart';
class ScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('First Screen'),
          onPressed: () {

            /*
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenThree()),
            );
            */


            Navigator.pushNamed(context, '/second',arguments: ScreenArguments(
              'Extract Arguments Screen',
              'This message is extracted in the build method.',
            ));
          },
        ),
      ),
    );
  }
}



//