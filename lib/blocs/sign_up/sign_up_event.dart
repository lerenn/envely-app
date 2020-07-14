import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInWithEmailButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String lastName;
  final String firstName;

  SignUpInWithEmailButtonPressed(
      {@required this.lastName,
      @required this.firstName,
      @required this.email,
      @required this.password});

  @override
  List<Object> get props => [lastName, firstName, email, password];
}
