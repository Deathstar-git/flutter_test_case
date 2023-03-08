import 'package:flutter/material.dart';
import '../models/models.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color:Colors.grey.shade200,
        child: ListTile(
      leading: const Text('Автор:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      title: Text(user.name),
      isThreeLine: false,
      subtitle: Text(user.email),
      dense: false,
    ))

    );


  }
}