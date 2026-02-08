import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/userlist_controller.dart';
import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/view/util/usercard_widget.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userListController = context.watch<UserListController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Locations"), centerTitle: true),
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          FutureBuilder<List<UserBaseResponse>>(
            future: userListController.futureLocations,
            builder: (context, snapshot) {
              if (userListController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (userListController.hasError) {
                return Center(
                  child: Text('Fehler: ${userListController.errorMessage}'),
                );
              }

              final users = snapshot.data ?? [];

              // ⬇️ Optional: wenn keine Locations vorhanden sind
              if (users.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async => userListController.reloadLocations(),
                  child: ListView(
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text("Keine Locations gefunden.")),
                    ],
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  const double headerHeight = 60;
                  int crossAxisCount = max(1, constraints.maxWidth ~/ 400);

                  final grid = GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      16 + headerHeight, // ✅ startet unter der Suchleiste
                      16,
                      16,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      //childAspectRatio: 4 / 3,
                      mainAxisExtent: 300,
                    ),
                    itemCount: users.length,
                    itemBuilder: (context, index) =>
                        UserCard(userbase: users[index]),
                  );

                  // ⬇️ Pull-to-refresh, damit du manuell neu laden kannst
                  return RefreshIndicator(
                    onRefresh: () async {
                      userListController.reloadLocations();
                    },
                    child: grid,
                  );
                },
              );
            },
          ),
          _buildSearchAndFilterBar(context, userListController),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterBar(
    BuildContext context,
    UserListController userListController,
  ) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: userListController.searchCtrl,
                onChanged: userListController.onSearchChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => userListController
                    .reloadLocations(), //gibt es nicht bei mappage
                decoration: InputDecoration(
                  hintText: "Suchen...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: userListController.searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            userListController.clearSearchResults();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: const Color.fromARGB(
                    255,
                    223,
                    222,
                    222,
                  ).withValues(alpha: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
