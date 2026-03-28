import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/controller/editmyprofile_controller.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class EditMyProfilePage extends StatelessWidget {
  const EditMyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final editController = context.watch<EditMyProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil bearbeiten"),
        actions: [
          TextButton(
            onPressed: editController.isSaving
                ? null
                : () async {
                    await editController.saveProfile();

                    if (context.mounted && !editController.hasError) {
                      GoRouter.of(context).pop(true);
                    }
                  },
            child: editController.isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Speichern"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: editController.formKey,
          child: ListView(
            children: [
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
    );
  }
}
