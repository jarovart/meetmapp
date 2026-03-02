import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  final int userId;

  const UserProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserProfileController>();

    controller.initLoad(userId: userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
        actions: [
          if (controller.canEdit)
            OutlinedButton.icon(
              onPressed: () async {
                // navigation to edit
                // context.push('/editProfile');
              },
              label: const Text("Edit"),
              icon: const Icon(Icons.edit_attributes_outlined),
            ),
        ],
      ),
      body: _buildBody(context, controller),
    );
  }

  Widget _buildBody(BuildContext context, UserProfileController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.hasError) {
      return Center(
        child: Text(controller.errorMessage ?? "Unbekannter Fehler"),
      );
    }
    final user = controller.userData;
    if (user == null) {
      return const Center(child: Text("Kein User geladen."));
    }

    final me = controller.myProfile;
    final dateFormat = DateFormat("dd.MM.yyyy");

    final profileUrl = user.profileUrl;
    final firstName = user.firstName;
    final lastName = user.lastName;
    final aboutMe = user.aboutMe;
    final joinedLocations = user.joinedLocationCount;
    final likedLocations = user.likedLocationCount;

    // createdLocations gibt’s nur bei me
    final createdLocations = me?.createdLocations;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            context,
            profileUrl: profileUrl,
            firstName: firstName,
            lastName: lastName,
            email: me?.email, // nur bei mir
            createdAt: me?.createdAt,
            dateFormat: dateFormat,
          ),
          const SizedBox(height: 24),
          _buildInfoSection(context, aboutMe: aboutMe),
          const SizedBox(height: 24),
          _buildStatsSection(
            context,
            createdLocations: createdLocations, // nullable
            joinedLocations: joinedLocations,
            likedLocations: likedLocations,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required String? profileUrl,
    required String firstName,
    required String lastName,
    required DateFormat dateFormat,
    String? email,
    DateTime? createdAt,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: (profileUrl != null && profileUrl.isNotEmpty)
              ? NetworkImage(profileUrl)
              : null,
          child: (profileUrl == null || profileUrl.isEmpty)
              ? Text(
                  firstName.isNotEmpty ? firstName[0].toUpperCase() : "?",
                  style: const TextStyle(fontSize: 30),
                )
              : null,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$firstName $lastName",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),

              if (email != null && email.isNotEmpty)
                Text(
                  email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),

              if (createdAt != null) ...[
                const SizedBox(height: 6),
                Text(
                  "Mitglied seit ${dateFormat.format(createdAt)}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, {required String? aboutMe}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Über mich", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              aboutMe?.isNotEmpty == true
                  ? aboutMe!
                  : "Keine Beschreibung vorhanden.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context, {
    required int? createdLocations,
    required int joinedLocations,
    required int likedLocations,
  }) {
    // Wenn nicht my profile: "Erstellt" weglassen oder als 0 anzeigen
    final items = <Widget>[
      if (createdLocations != null)
        _buildStatCard("Erstellt", createdLocations, Icons.create),
      _buildStatCard("Beigetreten", joinedLocations, Icons.group),
      _buildStatCard("Geliked", likedLocations, Icons.favorite),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map(
            (w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: w,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}
