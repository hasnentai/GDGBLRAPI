import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_list/models/HiveUserModel.dart';

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
  Box _userBox;

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc();
    Hive.registerAdapter(HiveUserAdapter());
    initHive();
  }

  void initHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _userBox = await Hive.openBox("user_new");
    this.setState(() {});
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
                  HiveUser _hiveUser;
                  _userBox.clear();
                  print(_userBox.length);
                  for (int i = 0; i < snapshot.data.data.data.length; i++) {
                    Data _data = snapshot.data.data.data[i];
                    _hiveUser = HiveUser(_data.id, _data.avatar, _data.email,
                        _data.firstName, _data.lastName);
                    _userBox.add(_hiveUser);
                  }
                  return UserListScreen(snapshot.data.data.data);
                  break;
                case Status.ERROR:
                  if (_userBox != null) {
                    // ignore: deprecated_member_use
                    return WatchBoxBuilder(
                      box: _userBox,
                      builder: (context, box) {
                        Map<dynamic, dynamic> raw = box.toMap();
                        List list = raw.values.toList();
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  height: 2.0,
                                  thickness: 0.2,
                                  color: Colors.black,
                                ),
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              HiveUser _userModelData = list[i];
                              return ListTile(
                                trailing: Icon(Icons.favorite),
                                leading: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      imageUrl: _userModelData.avatar,
                                    ),
                                  ),
                                ),
                                title: Text(_userModelData.firstName +
                                    " " +
                                    _userModelData.lastName),
                                subtitle: Text(_userModelData.email),
                              );
                            });
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
