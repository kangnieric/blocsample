import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/post_repository.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

@injectable
class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  final PostRepository postRepository;
  EditPostBloc({required this.postRepository}) : super(EditPostInitial()) {
    on<EditPostSubmitted>((event, emit) async {
    emit(EditPostInProgress());
    try {
      await postRepository.editPost(
        id: event.id,
        title: event.title,
        content: event.content,
      );
      emit(EditPostSuccess());
    } catch (e) {
      emit(EditPostFailure(e.toString()));
    }
  });
  }
}