import 'package:flutter/material.dart';
import 'package:flutter_app/TopMenuBar.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final TextEditingController _textController = new TextEditingController();
Future<Database> database;



class Dog {
  final int id;
   int number_count;
  int substract_or_add;


  Dog({this.id, this.number_count});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number_count': number_count,
    };
  }
}




void updateRecordsTwo(Dog dog) async {

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'item_namecount',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }
  updateDog(dog);


}

void initializeData() async
{
  database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), 'doggie_database.db'),
// When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
// Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE item_namecount(id INTEGER PRIMARY KEY, number_count INTEGER)",
      );
    },
// Set the version. This executes the onCreate function and provides a
// path to perform database upgrades and downgrades.
    version: 1,
  );
}



class SqlLiteExaple extends StatefulWidget {
  @override
  _SqlLiteExapleState createState() {
    return _SqlLiteExapleState();
  }
}

class _SqlLiteExapleState extends State<SqlLiteExaple> {
  String message = '';


  void fetchRecords(Dog dog) async
  {
    Future<List<Dog>> fetchItemNameCount() async {
      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('item_namecount');



      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          number_count: maps[i]['number_count'],

        );
      });



    }


    List<Dog> dogobj = await fetchItemNameCount();

    print(dogobj.length);

    if(dogobj.length==0){
      insertRecords(dog);
    }
    else if(dogobj.length>=1){

      if(dog.substract_or_add==1)

      dog.number_count =  dog.number_count  + dogobj.elementAt(0).number_count;

      else
        dog.number_count =  dogobj.elementAt(0).number_count  - dog.number_count;


      setState(() {

        message =  ""+dog.number_count.toString();

      });
      updateRecords(dog);
    }


    //print(dogobj.elementAt(0).number_count);



    //print(await dogs());




  }



  void insertRecords(Dog dog) async
  {


    Future<void> insertDog(Dog dog) async {
      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. Also specify the
      // `conflictAlgorithm`. In this case, if the same dog is inserted
      // multiple times, it replaces the previous data.
      await db.insert(
        'item_namecount',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );



    }


    setState(() {

      message =  ""+dog.number_count.toString();

    });
    insertDog(dog);

  }

  void updateRecords(Dog dog) async
  {


    Future<void> updateDog(Dog dog) async {
      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. Also specify the
      // `conflictAlgorithm`. In this case, if the same dog is inserted
      // multiple times, it replaces the previous data.
      await db.update(
        'item_namecount',
        dog.toMap(),
        where: 'id = ?',
        whereArgs: [dog.id],

      );
    }

    updateDog(dog);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    initializeData();
    var topmenu_bar =  AppBar(
      title: Text('Sqllite Sample'),
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

    return Scaffold(
      appBar: topmenu_bar,
      body: Container(
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField(
                controller: _textController,

              ),
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Add'),
                  onPressed: (){

                    final fido = Dog(
                      id: 0,
                      number_count: int.parse(_textController.text),
                    );
                  //  insertRecords(fido);
                    fido.substract_or_add = 1;

                    fetchRecords(fido);


                  }
                ),
           Padding(
             padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
             child: RaisedButton(
                   child: Text('Fetch Data'),
                   onPressed: (){


                   },
             ),
           ),



                RaisedButton(
                  child: Text('Substract'),
                  onPressed: (){
                   // Navigator.pop(context);
                    final fido = Dog(
                      id: 0,
                      number_count: int.parse(_textController.text),
                    );
                    //  insertRecords(fido);
                    fido.substract_or_add = 0;

                    fetchRecords(fido);


                  },
                ),


              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                RaisedButton(
                  child: Text('Back'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    child: Text('Download Sample'),
                    onPressed: (){
                      Navigator.pushNamed(context,'/FileDownload');
                    },
                  ),
                ),


              ],
            ),

        Text( "$message",style:TextStyle(
        fontSize: 20.0)

    ),

          ],
        ) ,

      ),

    );
  }
}