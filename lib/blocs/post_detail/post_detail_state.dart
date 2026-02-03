part of 'post_detail_bloc.dart';

abstract class PostDetailState extends Equatable {
  const PostDetailState();
  @override
  List<Object> get props => [];
}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoadInProgress extends PostDetailState {}

class PostDetailLoadSuccess extends PostDetailState {
  final Post post;
  const PostDetailLoadSuccess(this.post);
  @override
  List<Object> get props => [post];
}

class PostDetailLoadFailure extends PostDetailState {
  final String error;
  const PostDetailLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}