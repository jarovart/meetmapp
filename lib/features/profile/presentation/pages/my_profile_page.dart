import 'package:casttime/features/profile/presentation/cubit/my_profile_cubit.dart';
import 'package:casttime/features/profile/presentation/cubit/my_profile_state.dart';
import 'package:casttime/features/profile/presentation/widgets/user_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<MyProfileCubit>();
      if (cubit.state.profile == null) cubit.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileCubit, MyProfileState>(
      builder: (context, state) => ProfileBody(
        status: state.status,
        profile: state.profile,
        isMyProfile: true,
        onRetry: () => context.read<MyProfileCubit>().load(),
      ),
    );
  }
}
