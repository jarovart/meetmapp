import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';
import 'package:meetmaap/app/controller/editmyprofile_controller.dart';

class EditMyProfilePage extends StatelessWidget {
  const EditMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final editController = context.watch<EditMyProfileController>();
    final l10n = context.l10n;

    if (!editController.isOwnerOfProfile()) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.editProfile)),
        body: Center(child: Text(l10n.noAuthorization)),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(l10n.editProfile),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: OutlinedButton.icon(
                  onPressed: editController.isSaving
                      ? null
                      : () async {
                          await editController.saveProfile();

                          if (context.mounted && !editController.hasError) {
                            GoRouter.of(context).pop(true);
                          }
                        },
                  label: editController.isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.save),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: editController.formKey,
              child: ListView(
                children: [
                  if (editController.hasError) ...[
                    Center(
                      child: Text(
                        AppErrorMapper.toUserMessage(
                          editController.error!,
                          l10n,
                          fallback: l10n.profileUpdateFailed,
                        ),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  buildProfileImageSection(context, editController),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: editController.firstNameCtrl,
                    decoration: InputDecoration(labelText: l10n.firstName),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: editController.lastNameCtrl,
                    decoration: InputDecoration(labelText: l10n.familyName),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: editController.aboutMeCtrl,
                    maxLines: 6,
                    decoration: InputDecoration(labelText: l10n.aboutMe),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (editController.uploading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.uploading,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildProfileImageSection(
    BuildContext context,
    EditMyProfileController editController,
  ) {
    final l10n = context.l10n;

    return Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: editController.previewImageProvider,
          child: editController.previewImageProvider == null
              ? Text("FM", style: const TextStyle(fontSize: 24))
              : null,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: editController.isSaving
                  ? null
                  : () => pickProfileImage(context, editController),
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(l10n.selectImage),
            ),
            OutlinedButton.icon(
              onPressed: editController.isSaving
                  ? null
                  : () => editController.removeProfileImage(),
              icon: const Icon(Icons.delete_outline),
              label: Text(l10n.removeImage),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> pickProfileImage(
    BuildContext context,
    EditMyProfileController editController,
  ) async {
    final l10n = context.l10n;
    final picked = await editController.imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (picked == null) return;
    if (!context.mounted) return;

    final screen = MediaQuery.of(context).size;
    final cropperWidth = screen.width * 0.85;
    final cropperHeight = screen.height * 0.55;

    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: l10n.cropProfileImage,
          lockAspectRatio: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: l10n.cropProfileImage,
          aspectRatioLockEnabled: true,
        ),
        if (kIsWeb)
          WebUiSettings(
            context: context, // nur falls du Web nutzt
            presentStyle: WebPresentStyle.dialog,
            size: CropperSize(
              width: cropperWidth.clamp(280, 520).toInt(),
              height: cropperHeight.clamp(320, 700).toInt(),
            ),
            viewwMode: WebViewMode.mode_1,
            dragMode: WebDragMode.move,
            zoomable: true,
            scalable: true,
            movable: true,
            zoomOnTouch: true,
            zoomOnWheel: true,
          ),
      ],
    );

    if (cropped == null) return;

    editController.uploading = true;
    editController.callNotifier();
    try {
      final bytes = await cropped.readAsBytes(); //or picked v
      editController.selectedProfileImage = await compute(
        EditMyProfileController.compressImage,
        bytes,
      );
      editController.removeCurrentProfileImage = false;
    } catch (e, st) {
      debugPrint('Failed to process image: $e');
      debugPrintStack(stackTrace: st);

      editController.error = e;
    } finally {
      editController.uploading = false;
      editController.callNotifier();
    }
  }
}
