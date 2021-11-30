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

  AuthBloc(this._authFacade) : super(const AuthState.initial());

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield const AuthState.processing();
    yield* event.map(authCheckRequested: (e) async* {
      final userOption = await _authFacade.getSignedInUser();
      yield userOption.fold(() => const AuthState.unauthenticated(),
          (_) => const AuthState.authenticated());
    }, signedOut: (e) async* {
      await _authFacade.signOut();
      yield const AuthState.unauthenticated();
    });
  }
}
