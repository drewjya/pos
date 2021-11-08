import 'package:flutter/material.dart';
import 'package:pos/components/body.dart';

class LandingPages extends StatelessWidget {
  const LandingPages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome",
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
