import 'package:flutter/material.dart';

class LodingPage extends StatelessWidget {
  const LodingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: loding(),
    );
  }
}
class loding extends StatelessWidget {
  const loding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}