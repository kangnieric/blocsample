import 'package:formz/formz.dart';

// Validation for Post Title
class PostTitle extends FormzInput<String, String> {
  const PostTitle.pure() : super.pure('');
  const PostTitle.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Title cannot be empty';
  }
}