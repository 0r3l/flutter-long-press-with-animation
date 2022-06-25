import './widgets/circle_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  bool showRemove = false;
  bool isAnimationCompleted = false;
  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            break;
          case AnimationStatus.completed:
            isAnimationCompleted = true;
            _controller!.reverse();
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.dismissed:
            if (isAnimationCompleted) {
              setState(() {
                showRemove = !showRemove;
              });
              isAnimationCompleted = false;
            }
            break;
        }
      });
  }

  _onLongPressStart(LongPressStartDetails details) {
    if (!_controller!.isAnimating) {
      _controller!.forward();
    } else {
      _controller!.forward(from: _controller!.value);
    }
  }

  _onLongPressEnd(LongPressEndDetails details) {
    _controller!.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50],
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onLongPressStart: _onLongPressStart,
              onLongPressEnd: _onLongPressEnd,
              child: AnimatedBuilder(
                  animation: _controller!,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: ((_controller!.value * 0.2) + 1),
                      child: Container(
                        width: 50,
                        padding: EdgeInsets.all(10),
                        height: 50,
                        child: Stack(
                          children: <Widget>[
                            CircularProgres(value: _controller!.value),
                            Container(
                              child: showRemove
                                  ? Center(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.red[900],
                                        size: 25,
                                      ),
                                    )
                                  : FingerPrintIcon(value: _controller!.value),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.red[100]!,
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: Offset(3, 3)),
                          ],
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class FingerPrintIcon extends StatelessWidget {
  final double? value;
  FingerPrintIcon({this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 25,
          ),
        ),
      ],
    );
  }
}
