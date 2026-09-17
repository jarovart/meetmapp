import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/profile/domain/model/location_list_type.dart';
import 'package:casttime/features/profile/presentation/cubit/location_list_cubit.dart';
import 'package:casttime/features/profile/presentation/cubit/location_list_state.dart';
import 'package:casttime/features/profile/presentation/widgets/locationlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationTab<T extends LocationListCubit> extends StatelessWidget {
  const LocationTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, LocationListState>(
      builder: (context, state) {
        if (state.status == LoadStatus.loading ||
            state.status == LoadStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == LoadStatus.failure) {
          return Center(
            child: TextButton(
              onPressed: () => context.read<T>().load(),
              child: Text(context.l10n.reload),
            ),
          );
        }
        return LocationListTab(
          title: title,
          locations: state.locations,
          isLoading: false,
          isLoadingMore: state.isLoadingMore,
          hasMore: state.hasMore,
          onRetry: () => context.read<T>().load(),
          onLoadMore: () => context.read<T>().loadMore(),
        );
      },
    );
  }
}
