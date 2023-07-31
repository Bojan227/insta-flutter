import 'package:equatable/equatable.dart';

class EditBody extends Equatable {
  const EditBody(
      {required this.firstName,
      required this.lastName,
      required this.username});

  final String firstName;
  final String lastName;
  final String username;

  @override
  List<Object?> get props => [firstName, lastName, username];
}
