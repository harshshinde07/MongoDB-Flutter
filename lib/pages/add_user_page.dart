import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb_flutter/database/database.dart';
import 'package:mongodb_flutter/models/user.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    var widgetText = 'Add User';
    if (user != null) {
      nameController.text = user.name;
      phoneController.text = user.phone.toString();
      ageController.text = user.age.toString();
      widgetText = 'Update User';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widgetText),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(labelText: 'Age'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              child: ElevatedButton(
                child: Text(widgetText),
                onPressed: () {
                  if (user != null) {
                    updateUser(user);
                  } else {
                    insertUser();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  insertUser() async {
    final user = User(
      id: M.ObjectId(),
      name: nameController.text,
      phone: int.parse(phoneController.text),
      age: int.parse(ageController.text),
    );
    await MongoDatabase.insert(user);
    Navigator.pop(context);
  }

  updateUser(User user) async {
    print('updating: ${nameController.text}');
    final u = User(
      id: user.id,
      name: nameController.text,
      phone: int.parse(phoneController.text),
      age: int.parse(ageController.text),
    );
    await MongoDatabase.update(u);
    Navigator.pop(context);
  }
}
