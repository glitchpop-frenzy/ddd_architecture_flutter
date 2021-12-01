import 'package:ddd_architecture_flutter/domain/auth/i_auth_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade) : super(const AuthState.processing()) {
    on<AuthCheckRequested>((event, emit) async => _authCheckRequested);
    on<SignedOut>((event, emit) async => _signedOut);
  }

  Future<void> _authCheckRequested(
      AuthEvent event, Emitter<AuthState> emit) async {
    // ignore: avoid_print
    print('is this even called?');
    emit(const AuthState.processing());
    final userOption = await _authFacade.getSignedInUser();
    // ignore: avoid_print
    print('Auth Check Requested called');
    emit(userOption.fold(() => const AuthState.unauthenticated(),
        (_) => const AuthState.authenticated()));
  }

  Future<void> _signedOut(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.processing());
    await _authFacade.signOut();
    emit(const AuthState.unauthenticated());
  }
}
