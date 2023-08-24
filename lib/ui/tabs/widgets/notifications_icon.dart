import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/ui/tabs/widgets/notification_button.dart';

import '../../../blocs/notifications/bloc/notifications_bloc.dart';

class NotificationsIcon extends StatelessWidget {
  const NotificationsIcon({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final int numberOfUnreadNotifications =
        context.watch<NotificationsBloc>().state.numberOfUnreadNotifications();

    return numberOfUnreadNotifications == 0
        ? NotificationButton(
            scaffoldKey: scaffoldKey,
            numberOfUnreadNotifications: numberOfUnreadNotifications)
        : Stack(
            children: [
              NotificationButton(
                  scaffoldKey: scaffoldKey,
                  numberOfUnreadNotifications: numberOfUnreadNotifications),
              Positioned(
                right: 1,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Text(
                      '$numberOfUnreadNotifications',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
