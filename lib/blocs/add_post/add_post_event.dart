part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();
  @override
  List<Object> get props => [];
}

class AddPostSubmitted extends AddPostEvent {
  final String title;
  final String body;

  const AddPostSubmitted({required this.title, required this.body});

  @override
  List<Object> get props => [title, body];
}