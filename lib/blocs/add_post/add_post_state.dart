part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostInProgress extends AddPostState {}

class AddPostSuccess extends AddPostState {}

class AddPostFailure extends AddPostState {
  final String error;
  const AddPostFailure(this.error);
  @override
  List<Object> get props => [error];
}