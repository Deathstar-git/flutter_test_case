import 'package:flutter/material.dart';
import '../models/models.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
        child: ListTile(
          leading: Text(comment.email),
          title: Text(comment.name),
          isThreeLine: true,
          subtitle: Text(comment.body),
          dense: true,
        )


    );
  }
}