part of 'post_list_bloc.dart';

abstract class PostListState extends Equatable {
  const PostListState();
  @override
  List<Object> get props => [];
}

class PostListInitial extends PostListState {}

class PostListLoadInProgress extends PostListState {}

class PostDeleteInProgress extends PostListState {}

class PostListLoadSuccess extends PostListState {
  final List<Post> posts;
  const PostListLoadSuccess(this.posts);
  @override
  List<Object> get props => [posts];
}

class PostListLoadFailure extends PostListState {
  final String error;
  const PostListLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}