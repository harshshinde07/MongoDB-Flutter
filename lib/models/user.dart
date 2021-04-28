import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String name;
  final int age;
  final int phone;

  const User({this.id, this.name, this.age, this.phone});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'age': age,
      'phone': phone,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        age = map['age'],
        phone = map['phone'];
}
