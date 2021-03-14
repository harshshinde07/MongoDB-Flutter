part of 'data_bloc.dart';

@immutable
abstract class DataState extends Equatable {
  const DataState();
}

class DataLoading extends DataState {
  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {
  @override
  List<Object> get props => [];
}

class DataFailure extends DataState {
  final String error;

  const DataFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class DataLoaded extends DataState {
  final List<User> userList;

  const DataLoaded({@required this.userList});

  @override
  List<Object> get props => [userList];
}
