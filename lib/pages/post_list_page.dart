import 'package:bloc_example/pages/add_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_list/post_list_bloc.dart';
import '../data/post_repository.dart';
import 'edit_post_page.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          if (state is PostListLoadInProgress || state is PostListInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostListLoadFailure) {
            return Center(child: Text('Failed to load posts: ${state.error}'));
          }
          if (state is PostDeleteInProgress) {
            return const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Deleting post...'),
              ],
              ),
            );
          }
          if (state is PostListLoadSuccess) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  onTap: () => _navigateToEdit(context, post),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Delete Post'),
                          content: const Text('Are you sure you want to delete this post?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.of(dialogContext).pop(),
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                // Dispatch delete event to the bloc
                                context.read<PostListBloc>().add(DeletePostRequested(post.id));
                                Navigator.of(dialogContext).pop();
                              },
                            ),
                          ],
                        ),
                      );
              
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAdd(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddPostPage()),
    );
  }

  void _navigateToEdit(BuildContext context, Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditPostPage(
          postId: post.id,
          initialTitle: post.title,
          initialBody: post.content,
        ),
      ),
    );
  }
}