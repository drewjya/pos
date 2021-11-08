import 'package:flutter/material.dart';

class LandingPages extends StatelessWidget {
  const LandingPages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: const Center(
        child: Text('Isi'),
      ),
    );
  }
}
