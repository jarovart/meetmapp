import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/userlist_controller.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/app/view/util/usercard_widget.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserListController>();
    final users = controller.users;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.users), centerTitle: true),
      body: Stack(
        children: [
          if (controller.isLoading)
            const Center(child: CircularProgressIndicator()),

          if (!controller.isLoading && controller.hasError)
            Center(
              child: Text(
                AppErrorMapper.toUserMessage(
                  e,
                  l10n,
                  fallback: l10n.errorCallUsers,
                ),
              ),
            ),

          if (!controller.isLoading && users.isEmpty)
            RefreshIndicator(
              onRefresh: () async => controller.reloadUsers(),
              child: ListView(
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      (controller.searchCtrl.text.length <= 3)
                          ? l10n.useSearch
                          : l10n.usersNotFound,
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
    final l10n = context.l10n;

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
                  hintText: l10n.searching,
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
