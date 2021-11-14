import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos/database/product.dart';
import 'package:pos/pages/base.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory? dir = await getExternalStorageDirectory();
  await Hive.initFlutter(dir!.path);
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('product');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const BasePage(),
    );
  }
}
