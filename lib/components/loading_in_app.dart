import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingInApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Center(
          child: InkWell(onTap: () {},
              child: Text('LOADING')),
        ),

      ),
      body: Container(
        color: Colors.white70.withOpacity(0.8),
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.red,
            size: 50.0,
            duration: const Duration(seconds: 5),
          ),
        ),
      ),
    );
  }

}