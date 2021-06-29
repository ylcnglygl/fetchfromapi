import 'package:dio/dio.dart';
import 'package:guvenfuturetask/model/task_model.dart';

class ApiService {
  Future<List<Task>> fetchUsers() async {
    try {
      Response response =
          await Dio().get('https://api.jsonbin.io/b/5e9ab216435f5604bb43cfdd');
      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        var listUsers = getUsersData.map((i) => Task.fromJson(i)).toList();
        return listUsers;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
