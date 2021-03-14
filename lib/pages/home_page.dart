import 'package:flutter/material.dart';
import 'package:mongodb_flutter/pages/add_user_page.dart';
import 'package:mongodb_flutter/database/database.dart';
import 'package:mongodb_flutter/models/user.dart';
import 'package:mongodb_flutter/components/user_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDatabase.getDocuments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Something went wrong, try again.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('MongoDB Flutter'),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserCard(
                        user: User.fromMap(snapshot.data[index]),
                        onTapDelete: () async {
                          deleteUser(User.fromMap(snapshot.data[index]));
                        },
                        onTapEdit: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return AddUserPage();
                                },
                                settings: RouteSettings(
                                  arguments: User.fromMap(snapshot.data[index]),
                                ),
                              ));
                        }),
                  );
                },
                itemCount: snapshot.data.length,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return AddUserPage();
                  }));
                },
                child: Icon(Icons.add),
              ),
            );
          }
        }
      },
    );
  }

  deleteUser(User user) async {
    await MongoDatabase.delete(user);
  }
}
