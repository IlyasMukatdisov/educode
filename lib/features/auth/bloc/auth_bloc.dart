import 'package:educode/features/auth/bloc/auth_event.dart';
import 'package:educode/features/auth/bloc/auth_state.dart';
import 'package:educode/features/auth/provider/auth_provider.dart';
import 'package:educode/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthProvider provider})
      : super(const AuthStateUninitialized(isLoading: true)) {
    // INITIALIZE
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateWelcome(
          isLoading: false,
        ));
        return;
      }
      if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false));
      }
    });

    // LOG IN
    on<AuthEventLogIn>((event, emit) async {
      emit(AuthStateLoggedOut(
        isLoading: true,
        loadingText: AppLocalizations.current.login_loading,
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );

        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(isLoading: false));
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(isLoading: false));
          emit(AuthStateLoggedIn(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });

    // LOG OUT
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });

    on<AuthEventShouldRegister>(
      (event, emit) {
        emit(const AuthStateRegistering(isLoading: false));
      },
    );

    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;

        try {
          await provider.createUser(email: email, password: password);
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification(isLoading: false));
        } on Exception catch (e) {
          emit(AuthStateRegistering(exception: e, isLoading: false));
        }
      },
    );

    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    on<AuthEventForgotPassword>(
      (event, emit) async {
        emit(const AuthStateForgotPassword(
            isLoading: false, hasSentEmail: false));
        final email = event.email;
        if (email == null) {
          return;
        }

        emit(const AuthStateForgotPassword(
            isLoading: true, hasSentEmail: false));

        bool didSendEmail = false;
        Exception? exception;
        try {
          await provider.sendPasswordReset(toEmail: email);
          didSendEmail = true;
        } on Exception catch (e) {
          exception = e;
        }
        emit(AuthStateForgotPassword(
          isLoading: false,
          hasSentEmail: didSendEmail,
          exception: exception,
        ));
      },
    );

    on<AuthEventWelcomeLogin>(
      (event, emit) {
        emit(const AuthStateLoggedOut(isLoading: false));
      },
    );

    on<AuthEventWelcomeRegister>(
      (event, emit) {
        emit(const AuthStateRegistering(isLoading: false));
      },
    );

    on<AuthEventBackToWelcome>(
      (event, emit) {
        emit(const AuthStateWelcome(isLoading: false));
      },
    );
  }
}
