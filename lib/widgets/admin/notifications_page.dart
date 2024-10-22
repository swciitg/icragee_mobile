import 'package:flutter/material.dart';
import 'package:icragee_mobile/services/data_service.dart';
import 'package:icragee_mobile/shared/colors.dart';
import 'package:icragee_mobile/widgets/home_tab/notification_card.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.backgroundColor,
      child: StreamBuilder(
        stream: DataService.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: MyColors.primaryColor,
            ));
          }
          if (snapshot.hasError && !snapshot.hasData) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Something went wrong!'),
            ));
          }
          final notifications = snapshot.data!;
          if (notifications.isEmpty) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('No notifications yet!'),
            ));
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final noti = notifications[index];
              final timeAgo = timeago.format(
                  DateTime.parse(noti.timestamp).toLocal(),
                  locale: 'en_short');
              return Padding(
                  padding: EdgeInsets.fromLTRB(
                    15,
                    0,
                    15,
                    index == notifications.length - 1 ? 100 : 2,
                  ),
                  child: NotificationCard(noti: noti, timeAgo: timeAgo));
            },
          );
        },
      ),
    );
  }
}
