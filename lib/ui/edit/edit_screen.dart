import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/blocs/user/cubit/user_cubit.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/models/edit_body.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/ui/edit/profile_image_input.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';
import 'package:pettygram_flutter/widgets/image_input.dart';
import 'package:pettygram_flutter/widgets/input_field.dart';

class EditUserScreen extends StatelessWidget {
  EditUserScreen({super.key, required this.user});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final User user;

  String username = '';
  String firstName = '';
  String lastName = '';

  List<String> images = [];

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      EditBody editBody = EditBody(
          firstName: firstName, lastName: lastName, username: username);

      BlocProvider.of<UserCubit>(context).editUser(editBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: () => onSubmit(context),
            icon: const Icon(
              Icons.check,
              color: Color.fromARGB(255, 144, 202, 249),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserCubit, UserStateCubit>(
        listener: (context, state) {
          if (state is UserEditSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    ProfileImageInput(
                        handleImageInput: (image) => images = image,
                        imageUrl: user.imageUrl!),
                    TextButton(
                        onPressed: () {
                          if (images.isNotEmpty) {
                            BlocProvider.of<UserCubit>(context)
                                .uploadProfilePicture(images);
                          }
                        },
                        child: Text(
                          'Edit Picture',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InputField(
                            defaultValue: user.username,
                            handleInput: (value) => username = value,
                            obscureText: false,
                            label: 'Username'),
                        const SizedBox(
                          height: 12,
                        ),
                        InputField(
                            defaultValue: user.firstName,
                            handleInput: (value) => firstName = value,
                            obscureText: false,
                            label: 'First Name'),
                        const SizedBox(
                          height: 12,
                        ),
                        InputField(
                            defaultValue: user.lastName,
                            handleInput: (value) => lastName = value,
                            obscureText: false,
                            label: 'Last Name'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
