import 'package:flutter/material.dart';
import 'HomePage.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
/* 
  itemBuilder: (BuildContext context, int index) 
                       {
                        if(snakePosition.contains(index)){
                            return Center(
                           child:Container(
                             padding: EdgeInsets.all(2.0),
                             child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  color: Colors.white,
                                ),
                             ),
                           ),
                        );
                      }
                        ); */