import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/post_form_cubit.dart';

class PostForm extends StatelessWidget {
  final String? initialTitle;
  final String? initialContent;
  final VoidCallback onSubmit;

  const PostForm({
    super.key,
    this.initialTitle,
    this.initialContent,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    // The PostFormCubit is now provided by the parent widget (AddPostPage)
    // We also need to initialize the state here now.
    context.read<PostFormCubit>()
      ..titleChanged(initialTitle ?? '')
      ..contentChanged(initialContent ?? '');

    return BlocBuilder<PostFormCubit, PostFormState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<PostFormCubit>().titleChanged(value),
              decoration: InputDecoration(
                labelText: 'Title',
                errorText: state.title.invalid ? 'Title cannot be empty' : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) =>
                  context.read<PostFormCubit>().contentChanged(value),
              decoration: InputDecoration(
                labelText: 'Content',
                errorText:
                    state.body.invalid ? 'Content cannot be empty' : null,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.status.isValidated ? onSubmit : null,
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}