import 'dart:io';

import 'package:bloc_example/data/post_repository.dart';
import 'package:bloc_example/database/app_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPathProvider extends Mock {
  Future<Directory> getApplicationDocumentsDirectory() async {
    return Directory.systemTemp.createTempSync(); // Use a temporary directory for testing
  }
}

void main() {
  // Ensure Flutter bindings are initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Mock the path_provider plugin
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async {
        if (call.method == 'getApplicationDocumentsDirectory') {
          return Directory.systemTemp.path; // Use a temporary directory
        }
        return null;
      },
    );
  });

  group('PostRepository Tests', () {
    late AppDatabase database;
    late PostRepository repository;

    setUp(() {
      database = AppDatabase();
      repository = DriftPostRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('Add and fetch posts', () async {
      await repository.addPost('Test Title', 'Test Content');
      final posts = await repository.fetchPosts();
      //expect(posts.length, 1);
      expect(posts.first.title, 'Test Title');
      expect(posts.first.content, 'Test Content');
    });
  });
}