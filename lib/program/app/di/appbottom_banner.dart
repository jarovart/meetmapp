import 'package:casttime/extensions/l10n_extension.dart';
import 'package:casttime/program/app/di/appbanner_cubit.dart';
import 'package:casttime/program/app/di/appbanner_state.dart';
import 'package:casttime/program/core/failure/appfailure.dart';
import 'package:casttime/program/core/failure/appfailurelocalisation.dart';
import 'package:casttime/program/domain/exceptions/apifailuremapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomBanner extends StatelessWidget {
  const AppBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBannerCubit, AppBannerState>(
      buildWhen: (previous, current) {
        return previous.messageId != current.messageId ||
            previous.isVisible != current.isVisible;
      },
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 250),
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
    final colors = Theme.of(context).colorScheme;
    debugPrint("bannercontent");
    final message = failure.localizedMessage(context.l10n);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Material(
        elevation: 8,
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(Icons.wifi_off_rounded, color: colors.onErrorContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: colors.onErrorContainer),
                ),
              ),
              IconButton(
                tooltip: context.l10n.close,
                onPressed: () {
                  context.read<AppBannerCubit>().dismiss();
                },
                icon: Icon(Icons.close, color: colors.onErrorContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
