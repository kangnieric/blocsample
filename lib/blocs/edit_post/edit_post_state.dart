part of 'edit_post_bloc.dart';

abstract class EditPostState extends Equatable {
  const EditPostState();

  @override
  List<Object> get props => [];
}
class EditPostInitial extends EditPostState {}
class EditPostInProgress extends EditPostState {}
class EditPostSuccess extends EditPostState {}
class EditPostFailure extends EditPostState {
  final String error;
  const EditPostFailure(this.error);
  @override
  List<Object> get props => [error];
}