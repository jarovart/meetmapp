import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/navigation/widgets/back_bar.dart';
import 'package:casttime/app/navigation/widgets/dock_container.dart';
import 'package:casttime/app/navigation/widgets/dock_divider.dart';
import 'package:casttime/app/navigation/widgets/edit_action_icon.dart';
import 'package:casttime/app/navigation/widgets/locations_action_row.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/image/presentation/widgets/gallery_widget.dart';
import 'package:casttime/features/image/presentation/widgets/imageviewer_widget.dart';
import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/navigation_service.dart';
import 'package:casttime/features/location/presentation/bloc/location_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/location_event.dart';
import 'package:casttime/features/location/presentation/bloc/location_state.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_card.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key, required this.locationId, this.location});

  final Location? location;
  final int locationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<LocationBloc>(param1: location)
            ..add(LocationRequested(id: locationId)),
      child: _LocationDetailView(locationId: locationId),
    );
  }
}

class _LocationDetailView extends StatelessWidget {
  const _LocationDetailView({required this.locationId});

  final int locationId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<LocationBloc, LocationState>(
      listenWhen: (p, c) => p.failure != c.failure && c.failure != null,
      listener: (context, state) {
        context.read<AppBannerCubit>().showFailure(state.failure!);
      },
      builder: (context, state) {
        final location = state.location;

        return Scaffold(
          extendBody: true,
          bottomNavigationBar: DockContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (location != null) ...[
                  LocationActionsRow(
                    enabled: context.select<AuthCubit, bool>(
                      (c) => c.state.isLoggedIn,
                    ),
                    isLiked: location.likedByCurrentUser ?? false,
                    isJoined: location.joinedByCurrentUser ?? false,
                    likeCount: location.likedUserCount,
                    joinCount: location.joinedUserCount,
                    onLikeTap: () => context.read<LocationBloc>().add(
                      LocationLikeToggled(id: location.id),
                    ),
                    onJoinTap: () => context.read<LocationBloc>().add(
                      LocationJoinToggled(id: location.id),
                    ),
                  ),
                  const DockDivider(),
                ],
                BackBarRow(
                  title: location?.title ?? l10n.locationNotFound,
                  trailing: const EditAction(),
                ),
              ],
            ),
          ),
          body: BottomBarLayoutWidget(
            childWidget: _DetailBody(state: state, locationId: locationId),
          ),
        );
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.state, required this.locationId});

  final LocationState state;
  final int locationId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (state.status == LoadStatus.loading && state.location == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [const Center(child: CircularProgressIndicator())],
      );
    }

    if (state.status == LoadStatus.failure && state.location == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.failure?.localizedMessage(l10n) ??
                l10n.locationCouldNotBeLoaded,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => context.read<LocationBloc>().add(
              LocationRequested(id: locationId),
            ),
            child: Text(l10n.retry),
          ),
        ],
      );
    }

    final location = state.location!;
    final imageUrls = state.imageUrls;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeaderImage(location: location, imageUrls: imageUrls),
        InfoCard(
          child: InfoRow(
            icon: Icons.description_outlined,
            label: l10n.description,
            value: location.description,
          ),
        ),
        const SizedBox(height: 16),
        InfoCard(
          child: Column(
            children: [
              InfoRow(
                icon: Icons.event_available_outlined,
                label: l10n.chooseStartdate,
                value: _format(location.startDateTime),
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.event_busy_outlined,
                label: l10n.chooseEnddate,
                value: _format(location.endDateTime),
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.person_outline,
                label: l10n.createdBy,
                value: location.createdUsername,
                onTap: () => context.push(
                  RouteConfig.getProfileUrl(location.createdUsername),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        InfoCard(
          child: Column(
            children: [
              InfoRow(
                icon: Icons.map_outlined,
                value: location.address,
                onTap: () {
                  context.read<MapBloc>().add(
                    MapLocationSelected(
                      location,
                      zoom: 16,
                      newCreatedLocation: true,
                    ),
                  );
                  context.go(RouteConfig.mapUrl);
                },
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.navigation_outlined,
                value: l10n.navigateToLocation,
                onTap: () => getIt<NavigationService>().openNavigation(
                  location.position,
                ),
              ),
            ],
          ),
        ),
        if (imageUrls.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(l10n.images, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ImageGalleryWidget(
            imageUrls: imageUrls,
            dragHandle: AppConfig.isMobile(),
          ),
        ],
      ],
    );
  }

  String _format(DateTime dt) => DateFormat('dd.MM.yyyy HH:mm').format(dt);
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({required this.location, required this.imageUrls});

  final Location location;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GestureDetector(
        onTap: imageUrls.isEmpty
            ? null
            : () => Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) =>
                      ImageGalleryViewer(imageUrls: imageUrls, initialIndex: 0),
                ),
              ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'location-thumbnail-${location.id}',
              child: ThumbnailImage(
                imageUrl: location.thumbnailImage?.imageUrl,
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black26, Colors.black87],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
