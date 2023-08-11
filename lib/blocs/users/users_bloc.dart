import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';

import '../../models/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required this.pettygramRepository}) : super(UsersInitial()) {
    on<GetUsers>(_onGetUsers);
  }

  final PettygramRepository pettygramRepository;

  Future<void> _onGetUsers(GetUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoading());

    try {
      final List<User> users = await pettygramRepository.getUsers();

      emit(UsersLoaded(users: users));
    } catch (error) {
      emit(UsersFailed(error: error.toString()));
    }
  }
}
