import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/home_page.dart';
import 'common/services/notification_service.dart';

void main() {
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationService(),
      child: Builder(
        builder: (context) {
          final notificationService = Provider.of<NotificationService>(
            context,
            listen: false,
          );
          return MaterialApp(
            title: 'Meetmaap',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.green),
            scaffoldMessengerKey: notificationService.messengerKey,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
