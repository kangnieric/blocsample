import 'package:bloc_example/bloc/post_form_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  group('PostFormCubit', () {
    late PostFormCubit cubit;

    setUp(() {
      cubit = PostFormCubit();
    });

    test('initial state is pure', () {
      expect(cubit.state.status, FormzStatus.pure);
    });

    test('title validation works', () {
      cubit.titleChanged('');
      expect(cubit.state.title.invalid, true);

      cubit.titleChanged('Valid Title');
      expect(cubit.state.title.valid, true);
    });

    test('content validation works', () {
      cubit.contentChanged('');
      expect(cubit.state.body.invalid, true);

      cubit.contentChanged('Valid Content');
      expect(cubit.state.body.valid, true);
    });

    test('form is validated when both fields are valid', () {
      cubit.titleChanged('Valid Title');
      cubit.contentChanged('Valid Content');
      expect(cubit.state.status.isValidated, true);
    });
  });
}