// Define the database
import 'dart:io';

import 'package:bloc_example/database/tables/post.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@singleton
@DriftDatabase(tables: [Posts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Insert a post
  Future<int> insertPost(PostsCompanion post) => into(posts).insert(post);

  // Get all posts
  Future<List<Post>> getAllPosts() => select(posts).get();

  // Get a single post by ID
  Future<Post?> getPostById(int id) =>
      (select(posts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // Update a post
  Future<bool> updatePost(PostsCompanion post) {
    return (update(posts)..where((tbl) => tbl.id.equals(post.id.value)))
        .write(post)
        .then((value) => value > 0);
  }

  // Delete a post
  Future<int> deletePost(int id) =>
      (delete(posts)..where((tbl) => tbl.id.equals(id))).go();
}

// Open a persistent SQLite database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Get the application documents directory
    final dbFolder = await getApplicationDocumentsDirectory();
    // Create the database file path
    final file = File(p.join(dbFolder.path, 'app_database.db'));
    // Return the database connection
    return NativeDatabase(file);
  });
}