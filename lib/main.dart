import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];

  Future<void> readJson() async {
    final dynamic response = await rootBundle.loadString('/exercise_sample.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat'),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (context,data){
        return ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index){
            return Card(
              child:Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
              
              child: Row(
                children: [
                  Container(
                    child:Expanded(
                      flex: 1,
                      child: CircleAvatar(
                            backgroundImage: _items[index].containsKey("avatar") ? NetworkImage(_items[index]["avatar"]) : NetworkImage("https://www.vhv.rs/dpng/d/526-5268314_empty-avatar-png-user-icon-png-transparent-png.png"),
                          ),
                    )
                    
                  ),
                  Container(
                    child:Expanded(
                      flex: 4,
                        child: Container(
                           child:Column(
                            children:[
                            Row(
                              children: [
                                Text(_items[index]["first_name"] + " " + _items[index]["last_name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(_items[index]["username"]),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(_items[index].containsKey("status") ? _items[index]["status"] : "n/a", style: TextStyle(color: Colors.grey[500]),),
                              ],
                            ),
                          ]

                      ),
                    )),
                  ),
                  Container(
                    child:Expanded(
                      flex: 1,
                       child: Column(
                      children: [
                        Text(_items[index]["last_seen_time"]),
                        SizedBox(height: 4),
                        CircleAvatar(
                                    child: Text(_items[index].containsKey('messages')? _items[index]['messages'].toString(): '0', style: TextStyle(fontWeight: FontWeight.bold),),
                                  )
                        ],
                      ),

                    )
                   
                  ),
                ],
              ),
              ),
              );
          }

         );

      },
    ),);
  }
}
