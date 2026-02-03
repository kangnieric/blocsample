import 'package:bloc_example/bloc/post_form_cubit.dart';
import 'package:bloc_example/blocs/post_list/post_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../blocs/add_post/add_post_bloc.dart';
import '../injection.dart';
import '../ui/post_form.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AddPostBloc>(),
        ),
        BlocProvider(
          create: (context) => PostFormCubit(), // Provide PostFormCubit here
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Post'),
        ),
        body: BlocConsumer<AddPostBloc, AddPostState>(
          listener: (context, state) {
            if (state is AddPostInProgress) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Adding post...')),
                );
            }
            if (state is AddPostSuccess) {
              context.read<PostListBloc>().add(FetchPostsRequested());
              // Check if the widget is still in the tree before popping.
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(true);
              }
            }
            if (state is AddPostFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Failed to add post: ${state.error}')),
                );
              print('AddPostFailure: ${state.error}');
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: PostForm(
                onSubmit: () {
                  final cubit = context.read<PostFormCubit>();
                   print('Current state: ${cubit.state}');
                    print('Title valid: ${cubit.state.title.valid}');
                    print('Body valid: ${cubit.state.body.valid}');
                    print('Status: ${cubit.state.status}');
                    print('Is validated: ${cubit.state.status.isValidated}');
                    
                  if (cubit.state.status.isValidated) {
                    context.read<AddPostBloc>().add(
                          AddPostSubmitted(
                            title: cubit.state.title.value,
                            body: cubit.state.body.value,
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill out all fields correctly.')),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}