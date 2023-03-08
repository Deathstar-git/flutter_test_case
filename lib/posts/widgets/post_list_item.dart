import 'package:flutter/material.dart';
import '../models/post.dart';
import '../view/post_page.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: GestureDetector (
        onTap: () { Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(
              id: post.id,
              body: post.body,
              title: post.title,
              userId: post.userId,
            ),
          ),
        );
          },
        child: ListTile(
          leading: Text('${post.id}', style: textTheme.bodySmall),
          title: Text(post.title),
          isThreeLine: true,
          subtitle: Text(post.body),
          dense: true,
        )
      )

    );
  }
}