import 'package:formz/formz.dart';

// Validation for Post Content
class PostContent extends FormzInput<String, String> {
  const PostContent.pure() : super.pure('');
  const PostContent.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Content cannot be empty';
  }
}