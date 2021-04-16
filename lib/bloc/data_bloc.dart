import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mongodb_flutter/database/database.dart';
import 'package:mongodb_flutter/models/user.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataLoading());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is GetUsers) {
      // yield DataLoading();

      final usersList = await MongoDatabase.getDocuments();

      if (usersList == null) {
        yield DataFailure(error: 'Something went wrong, try again.');
      }

      List<User> users = [];
      for (final u in usersList) {
        users.add(User.fromMap(u));
      }
      print('yield loaded');
      yield DataLoaded(userList: users);
    }
    if (event is AddUser) {
      yield DataLoading();

      await MongoDatabase.insert(event.user);
      print('yield initial');
      yield DataInitial();
    }
    if (event is UpdateUser) {
      yield DataLoading();

      await MongoDatabase.update(event.user);
      print('yield initial');
      yield DataInitial();
    }
    if (event is DeleteUser) {
      yield DataLoading();

      await MongoDatabase.delete(event.user);
      print('yield initial');
      yield DataInitial();
    }
  }

  @override
  void onEvent(DataEvent event) {
    super.onEvent(event);
    print('onEvent: $event');
  }

  @override
  void onTransition(Transition<DataEvent, DataState> transition) {
    print('onTransition: ${transition.event} ${transition.currentState}');
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('onError: $error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
