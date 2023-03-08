import 'package:aspirity_test_case/posts/view/view.dart';
import 'package:flutter/material.dart';

class MyApp extends MaterialApp {
  MyApp({super.key}) : super(home:const PostsPage(), debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorSchemeSeed: const Color(0xfffcfcfc),
        useMaterial3: true),
  );

}