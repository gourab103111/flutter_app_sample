// Flutter code sample for material.BottomNavigationBar.1

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:flutter_app/ScreenTwo.dart';
import 'package:flutter_app/ScreenThree.dart';
import 'package:flutter_app/SqlLiteExample.dart';
import 'package:flutter_app/FileReadwrite.dart';
import 'package:flutter_app/MainPdfViewer.dart';
import 'package:flutter_app/VideoPlayerSample.dart';



void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => ScreenTwo(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => ScreenThree(),
        '/SampleSqlLite': (context) => SqlLiteExaple(),
        '/FileDownload': (context) => FileReadwrite(),
        '/MainPdfViewer': (context) => MainPdfViewer(),
        '/VideoPlayerSample': (context) => VideoPlayerSample(),

      },
      title: _title,

    );
  }
}


