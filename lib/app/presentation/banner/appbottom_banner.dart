import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/presentation/banner/appbanner_state.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomBanner extends StatelessWidget {
  const AppBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBannerCubit, AppBannerState>(
      buildWhen: (previous, current) =>
          previous.messageId != current.messageId ||
          previous.isVisible != current.isVisible,
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          alignment: Alignment.bottomCenter,
          child: state.isVisible
              ? _BannerContent(
                  key: ValueKey(state.messageId),
                  failure: state.failure!,
                )
              : const SizedBox(width: double.infinity, height: 0),
        );
      },
    );
  }
}

class _BannerContent extends StatelessWidget {
  const _BannerContent({required this.failure, super.key});

  final AppFailure failure;

  @override
  Widget build(BuildContext context) {
    final message = failure.localizedMessage(context.l10n);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.red, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
