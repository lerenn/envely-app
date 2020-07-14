import 'package:bloc/bloc.dart';

import 'package:Envely/blocs/authentication/authentication.dart';
import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/services/services.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  SignUpBloc(AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpInWithEmailButtonPressed) {
      yield* _mapSignUpWithEmailToState(event);
    }
  }

  Stream<SignUpState> _mapSignUpWithEmailToState(
      SignUpInWithEmailButtonPressed event) async* {
    yield SignUpLoading();
    try {
      final user = await _authenticationService.signUp(
          event.lastName, event.firstName, event.email, event.password);
      if (user != null) {
        // push new authentication event
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield SignUpSuccess();
        yield SignUpInitial();
      } else {
        yield SignUpFailure(error: 'Something very weird just happened');
      }
    } on AuthenticationException catch (e) {
      yield SignUpFailure(error: e.message);
    } catch (err) {
      yield SignUpFailure(error: err.messsage ?? 'An unknown error occured');
    }
  }
}
