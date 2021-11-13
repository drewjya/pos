import 'package:flutter/material.dart';
import 'package:pos/pages/home.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KasirKu",
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: SizedBox(
        width: size.width * 0.4,
        child: Drawer(
          semanticLabel: 'Hehe',
          child: ListView(
            children: [
              ListTile(
                title: const Text('Product'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Transaction'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: const HomeCashier(),
    );
  }
}