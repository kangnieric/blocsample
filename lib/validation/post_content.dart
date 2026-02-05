import 'package:formz/formz.dart';

class PostContent extends FormzInput<String, String> {
  const PostContent.pure([super.value = '']) : super.pure();

  const PostContent.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Content cannot be empty';
  }
}