import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:meetmaap/app/controller/editmyprofile_controller.dart';

class EditMyProfilePage extends StatelessWidget {
  const EditMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final editController = context.watch<EditMyProfileController>();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Profil bearbeiten"),
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
                      : const Text("Speichern"),
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
                  buildProfileImageSection(context, editController),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: editController.firstNameCtrl,
                    decoration: const InputDecoration(labelText: "Vorname"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: editController.lastNameCtrl,
                    decoration: const InputDecoration(labelText: "Nachname"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: editController.aboutMeCtrl,
                    maxLines: 6,
                    decoration: const InputDecoration(labelText: "Über mich"),
                  ),
                  if (editController.hasError) ...[
                    const SizedBox(height: 12),
                    Text(
                      editController.errorMessage ?? "Fehler",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (editController.isUploading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Loading...",
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
    return Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: editController.previewImageProvider,
          child: editController.previewImageProvider == null
              ? Text("NO", style: const TextStyle(fontSize: 24))
              : null,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: editController.isSaving
                  ? null
                  : () => editController.pickProfileImage(context),
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Bild wählen'),
            ),
            OutlinedButton.icon(
              onPressed: editController.isSaving
                  ? null
                  : () => editController.removeProfileImage(),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Bild entfernen'),
            ),
          ],
        ),
      ],
    );
  }
}
