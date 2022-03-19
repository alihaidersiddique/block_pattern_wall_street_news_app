import 'package:block_pattern_wall_street_news_app/news_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wall Street News',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsPage(),
    );
  }
}
