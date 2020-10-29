import 'package:bloc/bloc.dart';

import 'package:Envely/blocs/authentication/authentication.dart';
import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/repositories/repositories.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _repository;

  LoginBloc(AuthenticationBloc authenticationBloc,
      AuthenticationRepository repository)
      : assert(authenticationBloc != null),
        assert(repository != null),
        _authenticationBloc = authenticationBloc,
        _repository = repository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _repository.signInWithEmailAndPassword(
          event.email, event.password);
      if (user != null) {
        // push new authentication event
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
