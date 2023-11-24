import 'package:hive/hive.dart';
import 'package:hive_exam_project/model/user_model.dart';

class HomeController {
  final Box<UserModel> userbox = Hive.box('userdb');

  Future<List<UserModel>> getdata() async {
    return userbox.values.toList();
  }

  Future adddata(UserModel data) async {
    await userbox.add(data);
  }

  Future editdata({required int index, required UserModel data}) async {
    await userbox.putAt(index, data);
  }

  Future deletedata({required int index}) async {
    await userbox.deleteAt(index);
  }
}
