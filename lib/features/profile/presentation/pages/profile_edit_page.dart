import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/handler/edit_bar_host.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/permissions/photo_permission.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_edit_bloc.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_edit_event.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_edit_state.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_event.dart';
import 'package:casttime/features/setting/presentation/page/widget/edit_row.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_card.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileEditBloc>()..add(ProfileEditStarted()),
      child: const _ProfileEditView(),
    );
  }
}

class _ProfileEditView extends StatefulWidget {
  const _ProfileEditView();

  @override
  State<_ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<_ProfileEditView> with EditBarHost {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _aboutMeCtrl = TextEditingController();
  final _picker = ImagePicker();

  @override
  String get editBarOwnerId => 'profile-edit';

  @override
  bool get isBusy => context.read<ProfileEditBloc>().state.isBusy;

  @override
  VoidCallback get onEditBarCancel =>
      () => context.go(RouteConfig.myProfileUrl);

  @override
  VoidCallback get onEditBarReset => _resetForm;

  @override
  VoidCallback get onEditBarSave => _submit;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _aboutMeCtrl.dispose();
    super.dispose();
  }

  void _syncControllers(ProfileEditState state) {
    if (_firstNameCtrl.text != state.firstName) {
      _firstNameCtrl.text = state.firstName;
    }
    if (_lastNameCtrl.text != state.lastName) {
      _lastNameCtrl.text = state.lastName;
    }
    if (_aboutMeCtrl.text != state.aboutMe) {
      _aboutMeCtrl.text = state.aboutMe;
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    context.read<ProfileEditBloc>().add(ProfileEditReset());
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileEditBloc>().add(ProfileEditSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileEditBloc, ProfileEditState>(
      listenWhen: (p, c) =>
          p.status != c.status ||
          p.isBusy != c.isBusy ||
          p.isSaved != c.isSaved ||
          p.firstName != c.firstName ||
          p.lastName != c.lastName ||
          p.aboutMe != c.aboutMe ||
          p.failure != c.failure,
      listener: (context, state) {
        _syncControllers(state);
        publishEditBar();

        if (state.failure != null) {
          context.read<AppBannerCubit>().showFailure(state.failure!);
        }
        if (state.isSaved) {
          //final username = context.read<AuthCubit>().state.username;
          //context.read<UserProfileBloc>().add(UserProfileRequested(username));
          context.go(RouteConfig.myProfileUrl);
        }
      },
      builder: (context, state) => _EditBody(
        state: state,
        formKey: _formKey,
        firstNameCtrl: _firstNameCtrl,
        lastNameCtrl: _lastNameCtrl,
        aboutMeCtrl: _aboutMeCtrl,
        onPickImage: _pickImage,
      ),
    );
  }

  Future<void> _pickImage() async {
    final hasPermission = await RequestPhotoPermission.requestPhotoPermission();
    if (!mounted) return;

    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.noPhotoPermission),
          action: SnackBarAction(
            label: context.l10n.settings,
            onPressed: openAppSettings,
          ),
        ),
      );
      return;
    }

    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 90,
    );
    if (picked == null || !mounted) return;

    final cropped = await _cropSquare(picked.path);
    if (cropped == null || !mounted) return;

    final bytes = await cropped.readAsBytes();
    if (!mounted) return;

    context.read<ProfileEditBloc>().add(ProfileEditImageSelected(bytes));
  }

  Future<CroppedFile?> _cropSquare(String sourcePath) {
    final l10n = context.l10n;
    final screen = MediaQuery.of(context).size;

    return ImageCropper().cropImage(
      sourcePath: sourcePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: l10n.cropProfileImage,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: l10n.cropProfileImage,
          aspectRatioLockEnabled: true,
        ),
        if (kIsWeb)
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: CropperSize(
              width: (screen.width * 0.85).clamp(280, 520).toInt(),
              height: (screen.height * 0.55).clamp(320, 700).toInt(),
            ),
            viewwMode: WebViewMode.mode_1,
            dragMode: WebDragMode.move,
            zoomable: true,
            scalable: true,
            movable: true,
          ),
      ],
    );
  }
}

class _EditBody extends StatelessWidget {
  const _EditBody({
    required this.state,
    required this.formKey,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.aboutMeCtrl,
    required this.onPickImage,
  });

  final ProfileEditState state;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController aboutMeCtrl;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (state.status == LoadStatus.loading && state.original == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == LoadStatus.failure && state.original == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.failure?.localizedMessage(l10n) ??
                    l10n.profileUpdateFailed,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () =>
                    context.read<ProfileEditBloc>().add(ProfileEditStarted()),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        AppConfig.maxNavigationDockBarHeight,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConfig.maxAppWidth),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProfileImageSection(state: state, onPickImage: onPickImage),
                const SizedBox(height: 20),
                InfoCard(
                  child: Column(
                    children: [
                      EditRow(
                        icon: Icons.person_outline,
                        child: TextFormField(
                          controller: firstNameCtrl,
                          enabled: !state.isBusy,
                          decoration: InputDecoration(
                            labelText: l10n.firstName,
                          ),
                          onChanged: (v) => context.read<ProfileEditBloc>().add(
                            ProfileEditFirstNameChanged(v),
                          ),
                        ),
                      ),
                      const Divider(height: 24),
                      EditRow(
                        icon: Icons.badge_outlined,
                        child: TextFormField(
                          controller: lastNameCtrl,
                          enabled: !state.isBusy,
                          decoration: InputDecoration(
                            labelText: l10n.familyName,
                          ),
                          onChanged: (v) => context.read<ProfileEditBloc>().add(
                            ProfileEditLastNameChanged(v),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(
                  child: EditRow(
                    icon: Icons.notes_outlined,
                    child: TextFormField(
                      controller: aboutMeCtrl,
                      enabled: !state.isBusy,
                      maxLines: 6,
                      decoration: InputDecoration(labelText: l10n.aboutMe),
                      onChanged: (v) => context.read<ProfileEditBloc>().add(
                        ProfileEditAboutMeChanged(v),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileImageSection extends StatelessWidget {
  const _ProfileImageSection({required this.state, required this.onPickImage});

  final ProfileEditState state;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final source = state.avatarSource;

    final provider = switch (source) {
      AvatarFromMemory(:final bytes) => MemoryImage(bytes) as ImageProvider,
      AvatarFromNetwork(:final url) => NetworkImage(url),
      AvatarNone() => null,
    };

    final initials = ThumbnailImage.buildInitials(
      firstName: state.firstName,
      lastName: state.lastName,
      username: state.original?.username ?? 'CT',
    );

    return Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: provider,
          child: provider == null
              ? Text(initials, style: const TextStyle(fontSize: 24))
              : null,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: state.isBusy ? null : onPickImage,
              icon: state.isProcessingImage
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.photo_library_outlined),
              label: Text(l10n.selectImage),
            ),
            OutlinedButton.icon(
              onPressed: (state.isBusy || source is AvatarNone)
                  ? null
                  : () => context.read<ProfileEditBloc>().add(
                      ProfileEditImageRemoved(),
                    ),
              icon: const Icon(Icons.delete_outline),
              label: Text(l10n.removeImage),
            ),
          ],
        ),
      ],
    );
  }
}
