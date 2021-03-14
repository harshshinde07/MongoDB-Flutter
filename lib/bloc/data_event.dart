part of 'data_bloc.dart';

@immutable
abstract class DataEvent extends Equatable {
  const DataEvent();
}

class GetUsers extends DataEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends DataEvent {
  final User user;

  UpdateUser({this.user});

  @override
  List<Object> get props => [];
}

class AddUser extends DataEvent {
  final User user;

  AddUser({this.user});

  @override
  List<Object> get props => [];
}

class DeleteUser extends DataEvent {
  final User user;

  DeleteUser({this.user});

  @override
  List<Object> get props => [];
}
