
import 'package:fira/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final FiraAuthService  _authService;

  AuthenticationBloc(this._authenticationRepository) : super(AuthenticationInitial()) {

    on<AuthEvent>((event, emit) async {
      if (event is AuthenticationStarted){
        User? user = await _authService.retrieveCurrentUser().first;
        if( user!= null){
          String?  displayName = await _authService.retrieveUserName(user);
          emit(AuthenticationSuccess(displayName: displayName));
        }else{
          emit(AuthenticationFailure());
        }
      }else if(event is AuthenticationSignedOut){
        await _authService.signOut();
        emit(AuthenticationFailure());
      }
    });
  }

}