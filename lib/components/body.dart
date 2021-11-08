import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.amber,
          child: Row(
            children: [
              const Text('Babi'),
              MaterialButton(
                onPressed: () {},
                textColor: Colors.red,
                child: const Text('Babi'),
                elevation: 0,
              ),
            ],
          ),
        )
      ],
    );
  }
}
