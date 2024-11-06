import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhysicsAnimationDemo(),
    );
  }
}

class PhysicsAnimationDemo extends StatefulWidget {
  @override
  _PhysicsAnimationDemoState createState() => _PhysicsAnimationDemoState();
}

class _PhysicsAnimationDemoState extends State<PhysicsAnimationDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Simulation _simulation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _simulation = SpringSimulation(
      const SpringDescription(
        mass: 10.0,
        stiffness: 1000.0,
        damping: 10.0,
      ),
      _controller.value,
      1.0,  // Target position
      0.0,  // Initial velocity
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.animateWith(_simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Physics Animation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _controller.value * 100),
                  child: child,
                );
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startAnimation,
              child: Text('Start Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
