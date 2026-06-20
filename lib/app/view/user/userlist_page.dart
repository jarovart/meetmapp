import 'dart:math';
import 'package:flutter/material.dart';
import 'package:casttime/app/controller/userlist_controller.dart';
import 'package:casttime/app/view/util/app_errormessage_mapper.dart';
import 'package:casttime/app/view/util/usercard_widget.dart';
import 'package:casttime/extensions/l10n_extension.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Stack(
            children: [
              if (!controller.isLoading && users.isNotEmpty)
                LayoutBuilder(
                  builder: (context, constraints) {
                    const double headerHeight = 60;

                    return RefreshIndicator(
                      onRefresh: () => controller.reloadUsers(),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) => controller
                            .handleScrollNotification(context, notification),
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            16 + headerHeight,
                            16,
                            16,
                          ),
                          itemCount:
                              users.length + (controller.isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= users.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: UserCard(userbase: users[index]),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),

              if (!controller.isLoading &&
                  (users.isEmpty || controller.hasError))
                RefreshIndicator(
                  onRefresh: () async => controller.reloadUsers(),
                  child: ListView(
                    children: [
                      SizedBox(height: 200),
                      Center(
                        child: controller.hasError
                            ? Text(
                                AppErrorMapper.toUserMessage(
                                  e,
                                  l10n,
                                  fallback: l10n.errorCallUsers,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                (controller.searchCtrl.text.length <= 3)
                                    ? l10n.useSearch
                                    : l10n.usersNotFound,
                              ),
                      ),
                    ],
                  ),
                ),

              _buildSearchAndFilterBar(context, controller),

              if (controller.isLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.35),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
            ],
          ),
        ),
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
