import '../models/UserModel.dart';
import '../helpers/APIBase.dart';

class UserRepo {
  

  APIBase _helper = APIBase();

  Future <User> fetchUserList() async {
    final response = await _helper.get("users?page=1");
    return User.fromJson(response);
  }
}