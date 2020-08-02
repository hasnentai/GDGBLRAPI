import 'package:hive/hive.dart';

part 'HiveUserModel.g.dart';


@HiveType(typeId:0)
class HiveUser{
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String avatar;

  HiveUser(this.id,this.avatar,this.email,this.firstName,this.lastName);
}