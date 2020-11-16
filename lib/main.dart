import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('MY APP'),
      ),
      body: Center(
        child: MyRenderBoxWidget(),
      ),
    );
  }
}

class MyRenderBoxWidget extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyRenderBox();
  }
}

class _MyRenderBox extends RenderBox {
  ui.Image _img;

  @override
  bool hitTest(HitTestResult result, {@required Offset position}) {
    return true;
  }

  _MyRenderBox() {
    LoadAssetImage('image.jpg');
  }

  LoadAssetImage(String fname) => rootBundle.load("assets/$fname").then((bd) {
        Uint8List u8lst = Uint8List.view(bd.buffer);
        ui.instantiateImageCodec(u8lst).then((codec) {
          codec.getNextFrame().then((frameInfo) {
            _img = frameInfo.image;
            markNeedsPaint();
            print("_img created: $_img");
          });
        });
      });

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();
    Paint p = Paint();
    Offset off = Offset(dx + 50.0, dy + 50.0);

    if (_img != null) {
      c.drawImage(_img, off, p);
      print('draw _img');
    } else {
      print('_img is null.');
    }
  }
}
