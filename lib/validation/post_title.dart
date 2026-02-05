import 'package:formz/formz.dart';

class PostTitle extends FormzInput<String, String> {
  const PostTitle.pure([super.value = '']) : super.pure();

  const PostTitle.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Title cannot be empty';
  }
}