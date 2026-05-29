import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class LocationBottomActions extends StatelessWidget {
  final bool isLikeJoinAble;
  final bool isLiked;
  final bool isJoined;
  final int likeCount;
  final int joinCount;
  final VoidCallback onLikeTap;
  final VoidCallback onJoinTap;

  const LocationBottomActions({
    super.key,
    required this.isLikeJoinAble,
    required this.isLiked,
    required this.isJoined,
    required this.likeCount,
    required this.joinCount,
    required this.onLikeTap,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = context.read<AuthController>();
    final l10n = context.l10n;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        //color: const Color.fromARGB(255, 223, 222, 222).withValues(alpha: 0.7),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor.withValues(red: 1, alpha: 0.3),
          border: const Border(top: BorderSide(color: Color(0xFFE0E0E0))),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, -2),
              color: Color(0x12000000),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: isLikeJoinAble
                  ? OutlinedButton.icon(
                      onPressed: authController.isLoggedIn ? onLikeTap : null,
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(l10n.likesCount(likeCount)),
                    )
                  : countInfo(
                      Icons.favorite_border,
                      l10n.likesCount(likeCount),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isLikeJoinAble
                  ? ElevatedButton.icon(
                      onPressed: authController.isLoggedIn ? onJoinTap : null,
                      icon: Icon(
                        isJoined
                            ? Icons.check_circle
                            : Icons.group_add_outlined,
                      ),
                      label: Text(l10n.joinsCount(joinCount)),
                    )
                  : countInfo(Icons.group_outlined, l10n.joinsCount(joinCount)),
            ),
          ],
        ),
      ),
    );
  }

  Widget countInfo(IconData icon, String text) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
