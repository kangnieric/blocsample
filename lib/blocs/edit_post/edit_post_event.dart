part of 'edit_post_bloc.dart';

abstract class EditPostEvent extends Equatable {
  const EditPostEvent();
  
  @override
  List<Object> get props => [];
}

class EditPostSubmitted extends EditPostEvent {
  final int id;
  final String title;
  final String content;

  const EditPostSubmitted(
      {required this.id, required this.title, required this.content});

  @override
  List<Object> get props => [id, title, content];
}

