import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/models/login_body.dart';
import 'package:pettygram_flutter/utils/dialog_builder.dart';
import 'package:pettygram_flutter/widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<LoginBloc>().add(
            LoginRequest(
              loginBody: LoginBody(username: username, password: password),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputField(
                    handleInput: (value) => username = value,
                    obscureText: false,
                    label: 'username'),
                const SizedBox(
                  height: 14,
                ),
                InputField(
                    handleInput: (value) => password = value,
                    obscureText: true,
                    label: 'password'),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      context.go('/');
                    }

                    if (state is LoginFailed) {
                      dialogBuilder(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    return OutlinedButton(
                      onPressed: () {
                        onSubmit(context);
                      },
                      child:
                          Text(state is LoginLoading ? 'Loading..' : 'Login'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
