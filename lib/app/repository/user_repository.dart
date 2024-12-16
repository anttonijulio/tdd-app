import 'package:dio/dio.dart';

import '../entity/user.dart';

class UserRepository {
  late Dio dio;

  UserRepository({Dio? dio}) {
    this.dio = dio ?? Dio();
  }

  Future<User?> getUser(int id) async {
    try {
      var response = await dio.get('https://reqres.in/api/users/$id');

      if (response.statusCode == 200) {
        return User(
          id: response.data['data']['id'],
          name: response.data['data']['first_name'] +
              ' ' +
              response.data['data']['last_name'],
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
