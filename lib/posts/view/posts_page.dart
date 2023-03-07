import 'package:aspirity_test_case/posts/retrofit/api_client.dart';
import 'package:aspirity_test_case/posts/view/posts_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Посты')),

      body: BlocProvider(
        create: (_) => PostBloc(apiClient: ApiClient(Dio()))..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}