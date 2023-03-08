import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/comment_bloc.dart';
import '../bloc/user_bloc.dart';
import '../retrofit/api_client.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/user_item.dart';
import '../widgets/comment_item.dart';
import 'comments_list.dart';




class PostPage extends StatefulWidget {
  final int id;
  final String title;
  final String body;
  final int userId;

  const PostPage(
      {super.key,
        required this.id,
        required this.title,
        required this.body,
        required this.userId,
      });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пост № ${widget.id}'),
      ),
      body: BlocProvider(
        create: (_) => UserBloc(apiClient: ApiClient(Dio()), userId: widget.userId)..add(UserFetched()),
        child:  Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        padding:
        const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.black12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(widget.body),
            Container(child:  BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                switch (state.status) {
                  case UserStatus.failure:
                    return const Center(child: Text('ошибка загрузки данных об авторе'));
                  case UserStatus.success:
                        return UserItem(user: state.users[0]);
                  case UserStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            ),
          Expanded(child: BlocProvider(
            create: (_) => CommentBloc(apiClient: ApiClient(Dio()), postId: widget.id)..add(CommentFetched()),
            child: const CommentList()
            ),
          ),

          ],
        ),
      ),
      ),

    );
  }
}