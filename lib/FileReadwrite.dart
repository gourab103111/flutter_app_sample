import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_2/pdfviewer.dart';
import 'package:pdf_viewer_2/pdfviewer_plugin.dart';
import 'package:pdf_viewer_2/pdfviewer_scaffold.dart';

import 'package:flutter_app/ScreenArguments.dart';





class FileReadwrite extends StatefulWidget {
  @override
  _FileReadwriteState createState() {
    return _FileReadwriteState();
  }
}

class _FileReadwriteState extends State<FileReadwrite> {

  String _platformVersion = 'Unknown';
  Permission permission;
  String _tempPath    ='';
  String  _appDocPath ='';
  String  _external ='';




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

    final externalDirectory = await getExternalStorageDirectory();

    _external = externalDirectory.path;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });



  }


  @override
  initState() {
    super.initState();
    initPlatformState();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    String _platformVersion = 'Unknown';
    Permission permission;






    return Scaffold(
      appBar: AppBar(
        title: Text('Download Saple'),
        
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Download PDF'),
                    onPressed: (){

                      print(_appDocPath);
                      print(_tempPath);


                      HttpClient client = new HttpClient();
                      client.getUrl(Uri.parse("https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"))
                          .then((HttpClientRequest request) {
                        return request.close();
                      })
                          .then((HttpClientResponse response) {

                            print("File Downloaded ");
                        response.pipe(new File(_tempPath+'/dummy.pdf').openWrite());

                            Navigator.pushNamed(context, '/MainPdfViewer',arguments: ScreenArguments(
                              _tempPath+'/dummy.pdf',
                              'B1',
                            ));

                      });



                    },
                  ),
                ),
              ),
            ),





            new Column(children: <Widget>[
              new Text('Running on: $_platformVersion\n'),
              new DropdownButton(items: _getDropDownItems(), value: permission, onChanged: onDropDownChanged),
              new RaisedButton(onPressed: checkPermission, child: new Text("Check permission")),
              new RaisedButton(onPressed: requestPermission, child: new Text("Request permission")),
              new RaisedButton(onPressed: getPermissionStatus, child: new Text("Get permission status")),
              new RaisedButton(onPressed: SimplePermissions.openSettings, child: new Text("Open settings"))
            ]),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Download Video'),
                    onPressed: (){

                      print(_appDocPath);
                      print(_tempPath);




                      Navigator.pushNamed(context, '/VideoPlayerSample',arguments: ScreenArguments(
                        _external+'/vid2.mp4',
                        'B1',
                      ));

                      /*

                      HttpClient client = new HttpClient();
                      client.getUrl(Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"))
                          .then((HttpClientRequest request) {
                        return request.close();
                      })
                          .then((HttpClientResponse response) {

                        print("Video File Downloaded ");
                        response.pipe(new File(_external+'/butterfly.mp4').openWrite());

                        Navigator.pushNamed(context, '/VideoPlayerSample',arguments: ScreenArguments(
                          _external+'/butterfly.mp4',
                          'B1',
                        ));

                      });

                      */



                    },
                  ),
                ),
              ),
            ),
            

          ],
          
        ),
        
      ),
      
    );
  }



  Future<File> _getLocalFile(String filename) async {
 //   String dir = (await getApplicationDocumentsDirectory()).path;
    File f = new File(filename);
    return f;
  }


  onDropDownChanged(Permission permission) {
    setState(() => this.permission = permission);
    print(permission);
  }

  requestPermission() async {
    bool res = (await SimplePermissions.requestPermission(permission)) as bool;
    print("permission request result is " + res.toString());
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
  }

  getPermissionStatus() async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }

  List<DropdownMenuItem<Permission>>_getDropDownItems() {
    List<DropdownMenuItem<Permission>> items = new List();
    Permission.values.forEach((permission) {
      var item  = new DropdownMenuItem(child: new Text(getPermissionString(permission)), value: permission);
      items.add(item);
    });
    return items;
  }

}