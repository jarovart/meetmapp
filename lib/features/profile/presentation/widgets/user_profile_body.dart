import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/presentation/widgets/profile_scaffold.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.status,
    required this.profile,
    required this.isMyProfile,
    required this.onRetry,
  });

  final LoadStatus status;
  final UserProfile? profile;
  final bool isMyProfile;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (profile == null &&
        (status == LoadStatus.loading || status == LoadStatus.initial)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final loaded = profile;
    if (loaded == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.users)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.profileCouldNotBeLoaded),
              const SizedBox(height: 16),
              OutlinedButton(onPressed: onRetry, child: Text(l10n.retry)),
            ],
          ),
        ),
      );
    }

    return ProfileScaffold(profile: loaded, isMyProfile: isMyProfile);
  }
}
