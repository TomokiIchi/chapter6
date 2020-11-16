import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

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

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas c = context.canvas;
    int dx = offset.dx.toInt();
    int dy = offset.dy.toInt();

    if (_img != null) {
      c.drawImage(_img, Offset(dx + 50.0, dy + 50.0), Paint());
    }

    Paint p = Paint();
    p.style = PaintingStyle.fill;
    p.blendMode = BlendMode.darken;

    for (var i; i < 10; i++) {
      for (var j; j < 10; j++) {
        p.color = Color.fromARGB(255, 25 * i, 0, 25 * j);
        Rect r = Rect.fromLTWH(dx + 30.0 * i, dy + 30 * j, 30, 30);
        c.drawOval(r, p);
      }
    }
    c.save();

    Rect r = Rect.fromLTWH(dx + 70.0, dy + 70.0, 130.0, 130.0);
    c.clipRect(r);
    c.drawColor(Color.fromARGB(255, 255, 0, 0), BlendMode.darken);
    c.restore();
    r = Rect.fromLTWH(dx + 200.0, dy + 200.0, 130.0, 130.0);
    c.clipRect(r);
    c.drawColor(Color.fromARGB(255, 0, 255, 0), BlendMode.darken);
    c.restore();
  }
}
