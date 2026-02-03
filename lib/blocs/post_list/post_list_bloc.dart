import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/post_repository.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

@injectable
class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc(this._postRepository) : super(PostListInitial()) {
    on<FetchPostsRequested>(_onFetchPostsRequested);
    on<DeletePostRequested>(_onDeletePostRequested);
  }

  final PostRepository _postRepository;

  Future<void> _onFetchPostsRequested(
      FetchPostsRequested event, Emitter<PostListState> emit) async {
    emit(PostListLoadInProgress());
      try {
        final posts = await _postRepository.fetchPosts();
        emit(PostListLoadSuccess(posts));
      } catch (e) {
        emit(PostListLoadFailure(e.toString()));
      }
  }

  Future<void> _onDeletePostRequested(
      DeletePostRequested event, Emitter<PostListState> emit) async {
    if (state is PostListLoadSuccess) {
      final currentState = state as PostListLoadSuccess;
      emit(PostListLoadInProgress());
      try {
        emit(PostDeleteInProgress());
        await _postRepository.deletePost(event.postId);
        add(FetchPostsRequested());
        emit(PostListLoadSuccess(
            currentState.posts.where((post) => post.id != event.postId).toList()));
      } catch (e) {
        emit(PostListLoadFailure(e.toString()));
      }
    }
  }
}