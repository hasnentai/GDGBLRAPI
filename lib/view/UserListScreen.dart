import 'package:cached_network_image/cached_network_image.dart';

import '../models/UserModel.dart';
import 'package:flutter/material.dart';


class UserListScreen extends StatelessWidget {

  final List<Data> list;

  UserListScreen(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 2.0,
        thickness: 0.2,
        color: Colors.black,
      ),
      itemCount: list.length,
      itemBuilder: (context,i){
      return ListTile(
        trailing: Icon(Icons.favorite),
        leading:  Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      imageUrl: list[i].avatar,
                                    ),),
        ),
        title: Text(list[i].firstName +" "+ list[i].lastName),
        subtitle: Text(list[i].email),
        
      );
    });
  }
}