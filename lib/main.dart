import "package:flutter/material.dart";

void main() {
  runApp(new MaterialApp(home: new Homes()));
}

class Homes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.lightBlueAccent,
        width: 200.0,
        height: 100.0,
        child: new Center(
          child: new Text(
            "Halo",
            style: new TextStyle(
              color: Colors.white,
              fontFamily: "Serif",
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
