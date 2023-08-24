import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/notifications/bloc/notifications_bloc.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton(
      {super.key,
      required this.scaffoldKey,
      required this.numberOfUnreadNotifications});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int numberOfUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        scaffoldKey.currentState!.openEndDrawer();
        if (numberOfUnreadNotifications > 0) {
          context.read<NotificationsBloc>().add(const ReadNotifications());
        }
      },
      icon: const Icon(Icons.favorite_border),
    );
  }
}
