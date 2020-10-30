import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInWithEmailButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String name;

  SignUpInWithEmailButtonPressed(
      {@required this.name, @required this.email, @required this.password});

  @override
  List<Object> get props => [name, email, password];
}
