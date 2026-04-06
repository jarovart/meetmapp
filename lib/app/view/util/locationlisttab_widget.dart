import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';

class LocationListTab extends StatefulWidget {
  final String title;
  final List<LocationBaseResponse> locations;
  final bool isLoading;
  final VoidCallback onRetry;
  final Future<void> Function()? onLoadMore;
  final bool isLoadingMore;
  final bool hasMore;

  const LocationListTab({
    required this.title,
    required this.locations,
    required this.isLoading,
    required this.onRetry,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  @override
  State<LocationListTab> createState() => _LocationListTabState();
}

class _LocationListTabState extends State<LocationListTab> {
  bool _loadMoreTriggered = false;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.pixels >= notification.metrics.maxScrollExtent &&
        //statt pixel & maxscrollnotification.metrics.extentAfter < 200
        widget.hasMore &&
        !widget.isLoadingMore &&
        !_loadMoreTriggered) {
      _loadMoreTriggered = true;
      widget.onLoadMore?.call().whenComplete(() {
        if (mounted) {
          _loadMoreTriggered = false;
        }
      });
    }

    if (notification.metrics.pixels < notification.metrics.maxScrollExtent) {
      //notification.metrics.extentAfter >= 200
      _loadMoreTriggered = false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.locations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Keine Einträge vorhanden"),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: widget.onRetry,
              child: const Text("Neu laden"),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.separated(
        key: PageStorageKey(widget.title),
        padding: const EdgeInsets.all(16),
        itemCount: widget.locations.length + (widget.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index >= widget.locations.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final locationBase = widget.locations[index];

          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                context.push('/locationdetail', extra: locationBase);
              },
              child: ListTile(
                leading: locationBase.thumbnailImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          locationBase.thumbnailImage!.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.image),

                title: Text(locationBase.title),
                subtitle: Text(locationBase.description),
              ),
            ),
          );
        },
      ),
    );
  }
}
