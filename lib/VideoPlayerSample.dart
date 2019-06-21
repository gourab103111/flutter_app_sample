import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/ScreenArguments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoPlayerSample extends StatefulWidget {
  @override
  _VideoPlayerSampleState createState() {
    return _VideoPlayerSampleState();
  }
}

class _VideoPlayerSampleState extends State<VideoPlayerSample> {


  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  FutureBuilder _varFutureBuilder ;



  String _platformVersion = 'Unknown';
  Permission permission;
  String _tempPath    ='';
  String  _appDocPath ='';
  String video_path  = '';




  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    Directory tempDir = await getTemporaryDirectory();
    _tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    _appDocPath = appDocDir.path;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });



  }



  loadsharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("video_path", "/storage/emulated/0/vid3.mp4");
    video_path =  prefs.getString("video_path");



    print(video_path);


    /*
    setState(() {

      print(" Value for video file is changed ");


      _controller = VideoPlayerController.file(
        File('/storage/emulated/0/vid3.mp4'),
      );

      // Initielize the controller and store the Future for later use.
      _initializeVideoPlayerFuture = _controller.initialize();

      // Use the controller to loop the video.
      _controller.setLooping(true);




    });

    */


   // initcontrollers();
  }

  @protected
  Future<bool> loadWidget(BuildContext context, bool isInit) async {

   // final ScreenArguments args = ModalRoute.of(context).settings.arguments;
   // print(args.title);

    _controller = VideoPlayerController.file(
      File('/storage/emulated/0/vid3.mp4'),
    );

    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    print(video_path);

    return true;
  }


  @override
  void initState() {



    super.initState();
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    //args.title;



/*

    _controller = VideoPlayerController.file(
     File('/storage/emulated/0/vid3.mp4'),
    );

    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    */
  //  loadsharedPreference();





   // initcontrollers();

    _varFutureBuilder =  FutureBuilder(
        future: loadWidget(context, true),
        builder: (context, snapshot) {

          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: VideoPlayer(_controller),
          );


        }

    );





  }

  void initcontrollers() {



    print("initcontrollers");

    /*

    new Future.delayed(Duration.zero,() {

       ScreenArguments args = ModalRoute.of(context).settings.arguments;

      print(args.title);

       setState(() {
         video_path = args.title;
       });

    });
    */

  //  print(video_path);


    /*
    _controller = VideoPlayerController.file(
      File('/storage/emulated/0/vid2.mp4'),
    );

    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    */

  }



  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Column(
        children: <Widget>[
          RaisedButton(

            child: Text('Load video'),
            onPressed: (){

              setState(() {


                _controller = VideoPlayerController.file(
                  File('/storage/emulated/0/vid3.mp4'),
                );

                // Initielize the controller and store the Future for later use.
                _initializeVideoPlayerFuture = _controller.initialize();

                // Use the controller to loop the video.
                _controller.setLooping(true);

                _varFutureBuilder = FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );




              });




            },

          ),

          _varFutureBuilder,



        ],

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),

        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}