import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/post_repository.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

@injectable
class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository _postRepository;

  PostDetailBloc(this._postRepository) : super(PostDetailInitial()) {
    on<FetchPostDetailRequested>((event, emit) async {
      emit(PostDetailLoadInProgress());
      try {
        final post = await _postRepository.fetchPostDetails(event.postId);
        emit(PostDetailLoadSuccess(post!));
      } catch (e) {
        emit(PostDetailLoadFailure(e.toString()));
      }
    });
  }
}