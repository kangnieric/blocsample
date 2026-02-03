import 'package:bloc_example/blocs/add_post/add_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/post_list/post_list_bloc.dart';
import 'injection.dart';
import 'pages/post_list_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<PostListBloc>()..add(FetchPostsRequested())),
        BlocProvider(create: (context) => getIt<AddPostBloc>()),
      ],
      child : MaterialApp(
      title: 'BLoC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PostListPage(),
      ),
    );
  }
}