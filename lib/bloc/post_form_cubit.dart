import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import '../validation/post_content.dart';
import '../validation/post_title.dart';

class PostFormState {
  final PostTitle title;
  final PostContent body;
  final FormzStatus status;

  const PostFormState({
    this.title = const PostTitle.pure(),
    this.body = const PostContent.pure(),
    this.status = FormzStatus.pure,
  });

  PostFormState copyWith({
    PostTitle? title,
    PostContent? body,
    FormzStatus? status,
  }) {
    final updatedTitle = title ?? this.title;
    final updatedBody = body ?? this.body;

    return PostFormState(
      title: updatedTitle,
      body: updatedBody,
      status: status ?? Formz.validate([updatedTitle, updatedBody]),
    );
  }
}

class PostFormCubit extends Cubit<PostFormState> {
  PostFormCubit() : super(const PostFormState());

  void titleChanged(String value) {
    final title = PostTitle.dirty(value);
    emit(state.copyWith(
      title: title,
    ));
  }

  void contentChanged(String value) {
    final body = PostContent.dirty(value);
    emit(state.copyWith(
      body: body,
    ));
  }

  Future<void> submitPost() async {
    if (!state.status.isValidated) return;

    // Add your repository logic here
    //print('Submitting Post: ${state.title.value}, ${state.body.value}');
  }
}