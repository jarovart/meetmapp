import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/profile/presentation/bloc/user_search_bloc.dart';
import 'package:casttime/features/profile/presentation/bloc/user_search_event.dart';
import 'package:casttime/features/profile/presentation/bloc/user_search_state.dart';
import 'package:casttime/features/profile/presentation/widgets/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserSearchBloc>(),
      child: const _UserListView(),
    );
  }
}

class _UserListView extends StatelessWidget {
  const _UserListView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.users), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            children: [
              const _UserSearchBar(),
              Expanded(
                child: BlocBuilder<UserSearchBloc, UserSearchState>(
                  builder: (context, state) => _UserListBody(state: state),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserListBody extends StatelessWidget {
  const _UserListBody({required this.state});

  final UserSearchState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (state.status == LoadStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == LoadStatus.failure) {
      return _CenteredMessage(
        message: state.failure?.localizedMessage(l10n) ?? l10n.errorCallUsers,
        isError: true,
        onRetry: () =>
            context.read<UserSearchBloc>().add(UserSearchSubmitted()),
      );
    }

    if (state.users.isEmpty) {
      return _CenteredMessage(
        message: state.queryTooShort ? l10n.useSearch : l10n.usersNotFound,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is OverscrollNotification) {
          if (notification.metrics.extentAfter < 300) {
            context.read<UserSearchBloc>().add(UserSearchLoadMoreRequested());
          }
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        itemCount: state.users.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.users.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: UserCard(user: state.users[index]),
          );
        },
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.message,
    this.isError = false,
    this.onRetry,
  });

  final String message;
  final bool isError;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: isError
                  ? TextStyle(color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onRetry,
                child: Text(context.l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _UserSearchBar extends StatefulWidget {
  const _UserSearchBar();

  @override
  State<_UserSearchBar> createState() => _UserSearchBarState();
}

class _UserSearchBarState extends State<_UserSearchBar> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<UserSearchBloc>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (value) {
          bloc.add(UserSearchQueryChanged(value));
          setState(() {});
        },
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => bloc.add(UserSearchSubmitted()),
        decoration: InputDecoration(
          hintText: l10n.searching,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchCtrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchCtrl.clear();
                    bloc.add(UserSearchCleared());
                    setState(() {});
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
    );
  }
}
