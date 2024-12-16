import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_app/app/entity/user.dart';
import 'package:tdd_app/app/repository/user_repository.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const baseUrl = 'https://reqres.in/api/users';

  // success case
  test('Get user (Success)', () async {
    const userId = 2;

    when(dio.get('$baseUrl/$userId')).thenAnswer((_) {
      return Future.value(
        Response<dynamic>(
          requestOptions: RequestOptions(
            baseUrl: baseUrl,
            path: '$userId',
          ),
          data: {
            "data": {
              "id": 2,
              "email": "janet.weaver@reqres.in",
              "first_name": "Janet",
              "last_name": "Weaver",
              "avatar": "https://reqres.in/img/faces/2-image.jpg"
            },
            "support": {
              "url":
                  "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
              "text":
                  "Tired of writing endless social media content? Let Content Caddy generate it for you."
            }
          },
          statusCode: 200,
        ),
      );
    });

    User? user = await UserRepository(dio: dio).getUser(userId);

    expect(user, isNotNull);
    expect(user?.id, equals(userId));
    expect(user?.name, equals('Janet Weaver'));
  });

  // failed case
  test('Get user (Failed)', () async {
    const userId = 23;

    when(dio.get('$baseUrl/$userId')).thenAnswer((_) {
      return Future.value(
        Response<dynamic>(
          requestOptions: RequestOptions(
            baseUrl: baseUrl,
            path: '$userId',
          ),
          data: {},
          statusCode: 404,
        ),
      );
    });

    User? user = await UserRepository(dio: dio).getUser(userId);

    expect(user, isNull);
  });
}
