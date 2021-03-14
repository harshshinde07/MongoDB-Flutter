import 'package:flutter/cupertino.dart';

import 'database/database.dart';
import 'models/user.dart';

class UserData extends ChangeNotifier {
  getUsers() async {
    final usersList = await MongoDatabase.getDocuments();
    notifyListeners();
    return usersList;
  }

  addUser(User user) async {
    await MongoDatabase.insert(user);
    notifyListeners();
  }

  updateUsers(User user) async {
    await MongoDatabase.update(user);
    notifyListeners();
  }

  deleteUsers(User user) async {
    await MongoDatabase.delete(user);
    notifyListeners();
  }
}
