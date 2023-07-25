import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.dio}) : super(UsersInitial()) {
    on<GetUsers>(_onGetUsers);
  }

  final Dio dio;

  Future<void> _onGetUsers(GetUsers event, Emitter<UserState> emit) async {
    emit(UsersLoading());

    try {
      final usersResponse = await dio.get<dynamic>('/user');

      List<User> users = [];

      for (var user in usersResponse.data) {
        users.add(User.fromJson(user));
      }

      emit(UsersLoaded(users: users));
    } catch (error) {
      emit(UsersFailed(error: error.toString()));
    }
  }
}
