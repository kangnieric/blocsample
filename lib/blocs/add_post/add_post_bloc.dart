import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/post_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

@injectable
class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final PostRepository _postRepository;

  AddPostBloc(this._postRepository) : super(AddPostInitial()) {
    on<AddPostSubmitted>(_onAddPostSubmitted);
  }

  Future<void> _onAddPostSubmitted(
      AddPostSubmitted event, Emitter<AddPostState> emit) async {
    emit(AddPostInProgress());
    try {
      emit(AddPostInProgress());
      await _postRepository.addPost(event.title, event.body);
      emit(AddPostSuccess());
    } catch (e) {
      emit(AddPostFailure(e.toString()));
    }
  }
}