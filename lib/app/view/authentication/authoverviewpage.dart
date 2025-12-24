import 'package:flutter/material.dart';
import 'package:meetmaap/app/repositories/authrepository.dart';
import 'package:meetmaap/app/view/authentication/forgotpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/loginpage.dart';
import 'package:meetmaap/app/view/authentication/registertabpage.dart';

class AuthPage extends StatelessWidget {
  final bool returnOnSuccess;
  const AuthPage({super.key, this.returnOnSuccess = true});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Registrieren'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginPage(returnOnSuccess: returnOnSuccess),
            const RegisterTabPage(),
          ],
        ),
      ),
    );
  }
}
