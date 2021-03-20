import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {

  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer = new Completer<ui.Image>();
    // new NetworkImage('https://i.stack.imgur.com/lkd0a.png')
    //   .resolve(new ImageConfiguration())
    //   .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    // return completer.future;

     new NetworkImage('https://static1.purepeople.com.br/articles/6/28/08/16/@/3189562-vestido-preto-com-decote-ombro-a-ombro-950x0-2.jpg')
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    return completer.future;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Image Dimensions Example"),
      ),
      body: new Center(
        child: new FutureBuilder<ui.Image>(
          future: _getImage(),
          builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (snapshot.hasData) {
              ui.Image image = snapshot.data;
              return new Text(
                '${image.width}x${image.height}',
                style: Theme.of(context).textTheme.display4);
            } else {
              return new Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}