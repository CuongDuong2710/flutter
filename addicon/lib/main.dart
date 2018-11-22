import 'package:flutter/material.dart';

void main() {
  var app = MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Let see some images'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.playlist_play),
              tooltip: 'Play it',
              onPressed: _playIt,
            ),
            IconButton(
              icon: Icon(Icons.playlist_add),
              tooltip: 'Add it',
              onPressed: _addIt,
            )
          ],
        ),
        body: Center(
          child: Text('Body'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(height: 50.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
  );

  runApp(app);
}

void _addIt() {
 print("add It");
}

void _playIt() {
  print("play It");
}
