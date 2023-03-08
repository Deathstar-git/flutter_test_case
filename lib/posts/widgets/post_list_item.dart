import 'package:flutter/material.dart';
import '../models/post.dart';
import '../view/post_page.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top:5, bottom:5, right:20, left:0),
        decoration: BoxDecoration(
            border: Border.all(
              color:Colors.grey.shade300
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
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

          leading: Text('${post.id}'),
          title: Text(post.title),
          isThreeLine: true,
          subtitle: Text(post.body),
          dense: true,
        )
      )

    );
  }
}