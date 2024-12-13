import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/app/entity/user.dart';

void main() {
  group('Default user test', () {
    User user = User();

    test('Check user has id property with type int', () {
      expect(user.id, isA<int>());
    });

    test('Check user has name property with type string', () {
      expect(user.name, isA<String>());
    });

    test('Defaulit id = 0; Default name = "No Name"', () {
      expect(user.id, equals(0));
      expect(user.name, equals('No Name'));
    });
  });

  group('Custom user test', () {
    User user1 = User(id: 1);
    User user2 = User(name: 'Anton');
    User user3 = User(id: 1, name: 'Anton');

    test('Custom id (1), name ("No Name")', () {
      expect(user1.id, equals(1));
      expect(user1.name, equals('No Name'));
    });

    test('Custom id (0), name ("Anton")', () {
      expect(user2.id, equals(0));
      expect(user2.name, equals('Anton'));
    });

    test('Custom id (1), name ("Anton")', () {
      expect(user3.id, equals(1));
      expect(user3.name, equals('Anton'));
    });
  });
}
