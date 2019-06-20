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



class MainPdfViewer extends StatefulWidget {
  @override
  _MainPdfViewerState createState() {
    return _MainPdfViewerState();
  }
}

class _MainPdfViewerState extends State<MainPdfViewer> {

  String _platformVersion = 'Unknown';
  Permission permission;
  String _tempPath    ='';
  String  _appDocPath ='';


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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return  PDFViewerScaffold(
      appBar: AppBar(title: Text('PdfViewer'),),
      path: args.title,
    );
  }
}