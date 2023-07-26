import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';

import '../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.pettygramRepository}) : super(UsersInitial()) {
    on<GetUsers>(_onGetUsers);
  }

  final PettygramRepository pettygramRepository;

  Future<void> _onGetUsers(GetUsers event, Emitter<UserState> emit) async {
    emit(UsersLoading());

    try {
      final List<User> users = await pettygramRepository.getUsers();

      emit(UsersLoaded(users: users));
    } catch (error) {
      print(error);
      emit(UsersFailed(error: error.toString()));
    }
  }
}
