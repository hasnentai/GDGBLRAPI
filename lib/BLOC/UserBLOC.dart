import 'dart:async';


import '../repo/UserRepo.dart';
import '../helpers/APPState.dart';
import '../models/UserModel.dart';

class UserBloc {
  UserRepo _userRepo;

  StreamController _userListController;

  StreamSink<AppState<User> >get userListSink =>
      _userListController.sink;

  Stream<AppState<User>> get userListStream =>
      _userListController.stream;

  UserBloc() {
    _userListController = StreamController<AppState<User>>();
    _userRepo = UserRepo();
    fetchUserList();
  }

  fetchUserList() async {
    userListSink.add(AppState.loading('Fetching Users'));
    try {
      User user = await _userRepo.fetchUserList();
      userListSink.add(AppState.completed(user));
    } catch (e) {
      userListSink.add(AppState.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _userListController?.close();
  }
}