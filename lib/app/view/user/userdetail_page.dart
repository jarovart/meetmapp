import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/service/user_service.dart';

class UserDetailPage extends StatefulWidget {
  final UserBaseResponse userBase;

  const UserDetailPage({super.key, required this.userBase});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late final Future<UserFullResponse> _future;

  @override
  void initState() {
    super.initState();

    _future = widget.userBase is UserFullResponse
        ? Future.value(widget.userBase as UserFullResponse)
        : UserService.fetchFullUser(widget.userBase);
  }

  @override
  Widget build(BuildContext context) {
    final base = widget.userBase;

    return Scaffold(
      appBar: AppBar(title: Text(base.username), centerTitle: true),
      body: FutureBuilder<UserFullResponse>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Fehler beim Laden des Users:\n${snap.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _future = UserService.fetchFullUserById(base.id);
                      }),
                      child: const Text("Erneut versuchen"),
                    ),
                  ],
                ),
              ),
            );
          }

          final user = snap.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: (user.profileUrl?.isNotEmpty ?? false)
                          ? NetworkImage(user.profileUrl!)
                          : null,
                      child: (user.profileUrl?.isNotEmpty ?? false)
                          ? null
                          : Text(
                              user.username.isNotEmpty
                                  ? user.username[0].toUpperCase()
                                  : "?",
                              style: const TextStyle(fontSize: 24),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          if ((user.firstName?.isNotEmpty ?? false))
                            Text(
                              user.firstName!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                if ((user.aboutMe?.isNotEmpty ?? false)) ...[
                  Text(
                    "Über mich",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(user.aboutMe!),
                  const SizedBox(height: 16),
                ],

                // Stats (optional)
                Row(
                  children: [
                    _StatChip(
                      label: "Followers",
                      value: user.likedLocationCount,
                    ),
                    const SizedBox(width: 8),
                    _StatChip(label: "Folgt", value: user.likedLocationCount),
                    const SizedBox(width: 8),
                    _StatChip(
                      label: "Locations",
                      value: user.joinedLocationCount,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: DM / chat route
                        },
                        icon: const Icon(Icons.message_outlined),
                        label: const Text("Nachricht"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: follow/unfollow
                        },
                        icon: const Icon(Icons.person_add_alt_1),
                        label: const Text("Folgen"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text("$label: $value"));
  }
}
