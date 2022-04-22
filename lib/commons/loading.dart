import 'package:flutter/material.dart';
//In this function we are just making loading circular indicator
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}


