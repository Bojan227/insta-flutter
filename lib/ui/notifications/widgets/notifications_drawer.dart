import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/ui/notifications/widgets/like_notification.dart';
import '../../../blocs/notifications/bloc/notifications_bloc.dart';

class NotificationsDrawer extends StatelessWidget {
  const NotificationsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: SingleChildScrollView(
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Notifications',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                ...state.notifications.map(
                  (notification) =>
                      LikeNotification(notification: notification),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
