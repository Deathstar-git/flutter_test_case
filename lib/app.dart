import 'package:aspirity_test_case/posts/view/posts_page.dart';
import 'package:flutter/material.dart';

class App extends MaterialApp {
  const App({super.key}) : super(home: const PostsPage(), debugShowCheckedModeBanner: false,);
}