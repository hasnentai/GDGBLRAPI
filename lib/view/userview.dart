import '../models/UserModel.dart';
import '../helpers/APPState.dart';
import '../BLOC/UserBLOC.dart';
import 'package:flutter/material.dart';

import 'LoadingScreen.dart';
import 'UserListScreen.dart';
import 'ErrorScreen.dart';
class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User')),
      
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchUserList(),
        child: StreamBuilder<AppState<User>>(
          stream: _bloc.userListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return LoadingScreen(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return UserListScreen(snapshot.data.data.data);
                  break;
                case Status.ERROR:
                  return ErrorScreen(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchUserList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}