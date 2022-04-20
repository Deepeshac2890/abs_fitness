import 'package:abs_fitness/login/bloc.dart';
import 'package:abs_fitness/login/event.dart';
import 'package:abs_fitness/login/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

void main() {
  MockFirebaseAuth mfa;
  MockFirebaseUser mfu;
  LoginBloc bloc;
  String fakeEmail = 'Deepesh@gmail.com';
  String fakePass = 'password';
  setUp(() {
    mfa = MockFirebaseAuth();
    mfu = MockFirebaseUser();
    bloc = LoginBloc(mfa);
  });

  group("Test Login using mail and password", () {
    test('Test Logging in using email and pass', () async {
      when(mfa.signInWithEmailAndPassword(email: fakeEmail, password: fakePass))
          .thenAnswer((_) async => mfu);

      // bool res = await bloc.loginUsingEmail('deep', 'pass');
      // expect(res, true);
      bloc.add(LoginUsingMailEvent(fakeEmail, fakePass));
      expectLater(
          bloc, emitsInOrder([LoadingState(), LoginSuccess(true, null)]));
      await bloc.close();
    });

    test('Test Logging in using mail and fail', () async {
      when(mfa.signInWithEmailAndPassword(email: fakeEmail, password: fakePass))
          .thenThrow(Exception());
      bloc.add(LoginUsingMailEvent(fakeEmail, fakePass));
      expectLater(
          bloc,
          emitsInOrder([
            LoadingState(),
            LoginSuccess(false, "Login Attempt was unsuccessful")
          ]));
    });
  });

  group("Test sending reset link", () {
    test('Pass Case', () async {
      when(mfa.sendPasswordResetEmail(email: fakeEmail))
          .thenAnswer((realInvocation) async => null);
      bloc.add(SendResetLinkEvent(fakeEmail));
      expectLater(bloc, emitsInOrder([ResetSuccess(true, null)]));
    });

    test('Fail Case', () async {
      when(mfa.sendPasswordResetEmail(email: fakeEmail)).thenThrow(Exception());
      bloc.add(SendResetLinkEvent(fakeEmail));
      expectLater(
          bloc, emitsInOrder([ResetSuccess(false, "Reset Link was not sent")]));
    });
  });
}
