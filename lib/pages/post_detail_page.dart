import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_detail/post_detail_bloc.dart';
import '../injection.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  // A factory constructor to provide the BLoC for this page
  static Widget create({required int postId}) {
    return BlocProvider(
      create: (context) => getIt<PostDetailBloc>()..add(FetchPostDetailRequested(postId)),
      child: const PostDetailPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, state) {
          if (state is PostDetailLoadInProgress || state is PostDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostDetailLoadFailure) {
            return Center(child: Text('Failed to load post: ${state.error}'));
          }
          if (state is PostDetailLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.post.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(state.post.content),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}