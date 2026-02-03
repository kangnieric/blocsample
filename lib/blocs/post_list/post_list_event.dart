part of 'post_list_bloc.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();
  @override
  List<Object> get props => [];
}

class FetchPostsRequested extends PostListEvent {}

class DeletePostRequested extends PostListEvent {
  final int postId;

  const DeletePostRequested(this.postId);

  @override
  List<Object> get props => [postId];
}