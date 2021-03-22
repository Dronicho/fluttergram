part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.authenticationUserChanged(User? user) = _AuthenticationUserChanged;
  const factory AuthenticationEvent.authenticationLogoutRequested() = _AuthenticationLogoutRequested;
  
}