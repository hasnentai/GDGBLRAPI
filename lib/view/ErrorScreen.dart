import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final dynamic onRetryPressed;
  ErrorScreen({this.errorMessage,this.onRetryPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$errorMessage",textAlign: TextAlign.center,),
          ),
          FlatButton(onPressed: this.onRetryPressed,child: Text("Retry"),)
        ],),
      ),
    );
  }
}