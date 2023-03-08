import 'package:flutter/material.dart';
import '../models/models.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
            child: ListTile(
              title: Text(user.name),
              isThreeLine: true,
              subtitle: Text(user.email),
              dense: true,
            )


    );
  }
}