import 'package:bloc_example/bloc/post_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/edit_post/edit_post_bloc.dart';
import '../injection.dart';
import '../ui/post_form.dart';

class EditPostPage extends StatelessWidget {
  final int postId;
  final String initialTitle;
  final String initialBody;

  const EditPostPage({
    super.key,
    required this.postId,
    required this.initialTitle,
    required this.initialBody,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EditPostBloc>(),
        ),
        BlocProvider(
          create: (context) => PostFormCubit(), // Provide PostFormCubit here
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Post'),
        ),
        body: BlocConsumer<EditPostBloc, EditPostState>(
          listener: (context, state) {
            if (state is EditPostSuccess) {
              Navigator.of(context).pop(true);
            }
            if (state is EditPostFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Failed to edit post: ${state.error}')),
                );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: PostForm(
                initialTitle: initialTitle,
                initialContent: initialBody,
                onSubmit: () {
                  final cubit = context.read<PostFormCubit>();
                  context.read<EditPostBloc>().add(
                        EditPostSubmitted(
                          id: postId,
                          title: cubit.state.title.value,
                          content: cubit.state.body.value,
                        ),
                      );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}