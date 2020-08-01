import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String loadingMessage;

  LoadingScreen({this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            Text("$loadingMessage"),
          ],
        ),
      ),
    );
  }
}
