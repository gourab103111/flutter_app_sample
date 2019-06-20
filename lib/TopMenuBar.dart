import 'package:flutter/material.dart';

var topmenu_bar =  AppBar(
title: Text('Second Screen'),
leading: IconButton(
icon: Icon(
Icons.menu,
semanticLabel: 'menu',
),
onPressed: () {
print('Menu button');
},
),
);