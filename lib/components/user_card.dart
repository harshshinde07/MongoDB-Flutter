import 'package:flutter/material.dart';
import 'package:mongodb_flutter/models/user.dart';

class UserCard extends StatelessWidget {
  UserCard({this.user, this.onTapDelete, this.onTapEdit});
  final User user;
  final Function onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          '${user.age}',
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(user.name),
        subtitle: Text('${user.phone}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: onTapEdit,
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            ),
          ],
        ),
      ),
    );
  }
}
