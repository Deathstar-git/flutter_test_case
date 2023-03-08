import 'package:flutter/material.dart';
import '../models/models.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Автор:${comment.email}', style: TextStyle(fontSize: 12,
              fontWeight: FontWeight.bold,
              color:Colors.grey.shade300,
              ),
            textAlign: TextAlign.left,
            ),
            ListTile(

            tileColor: Colors.grey.shade50,
            title: Text(comment.name),
            isThreeLine: false,
            subtitle: Text(comment.body),
            dense: true,
          )]
        )


    );
  }
}