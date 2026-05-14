import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/userlist_controller.dart';
import 'package:meetmaap/app/view/util/usercard_widget.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserListController>();
    final users = controller.users;

    return Scaffold(
      appBar: AppBar(title: const Text("Benutzer"), centerTitle: true),
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          if (controller.isLoading)
            const Center(child: CircularProgressIndicator()),

          if (!controller.isLoading && controller.hasError)
            Center(child: Text('Fehler: ${controller.errorMessage}')),

          if (!controller.isLoading && users.isEmpty)
            RefreshIndicator(
              onRefresh: () async => controller.reloadUsers(),
              child: ListView(
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      (controller.searchCtrl.text.length <= 3)
                          ? "Bitte Namen eingeben."
                          : "Keine Benutzer gefunden.",
                    ),
                  ),
                ],
              ),
            ),

          if (!controller.isLoading && users.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                const double headerHeight = 60;
                final int crossAxisCount = max(1, constraints.maxWidth ~/ 400);

                return RefreshIndicator(
                  onRefresh: () => controller.reloadUsers(),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) => controller
                        .handleScrollNotification(context, notification),
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        16 + headerHeight,
                        16,
                        16,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 300,
                      ),
                      itemCount:
                          users.length + (controller.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= users.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final user = users[index];
                        return UserCard(userbase: user);
                      },
                    ),
                  ),
                );
              },
            ),

          _buildSearchAndFilterBar(context, controller),
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
                    .reloadUsers(), //gibt es nicht bei mappage
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
