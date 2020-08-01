
import 'package:flutter/material.dart';
import 'view/userview.dart';

void main(){
  runApp(DisplayDetails());
}


class DisplayDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisplayDetailsInner() ,
    );
  }
}




class DisplayDetailsInner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserScreen(),
    );
  }
}