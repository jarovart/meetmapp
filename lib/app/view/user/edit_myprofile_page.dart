import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:provider/provider.dart';

class EditMyProfilePage extends StatefulWidget {
  const EditMyProfilePage({super.key});

  @override
  State<EditMyProfilePage> createState() => _EditMyProfilePageState();
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController aboutMeCtrl;

  @override
  void initState() {
    super.initState();
    final c = context.read<UserProfileController>();
    final u = c.myProfile; // nur mein Profil
    firstNameCtrl = TextEditingController(text: u?.firstName ?? "");
    lastNameCtrl = TextEditingController(text: u?.lastName ?? "");
    aboutMeCtrl = TextEditingController(text: u?.aboutMe ?? "");
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    aboutMeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<UserProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil bearbeiten"),
        actions: [
          TextButton(
            onPressed: c.isSaving
                ? null
                : () async {
                    if (!_formKey.currentState!.validate()) return;

                    await c.updateMyProfile(
                      firstName: firstNameCtrl.text.trim(),
                      lastName: lastNameCtrl.text.trim(),
                      aboutMe: aboutMeCtrl.text.trim(),
                    );

                    if (mounted && !c.hasError) {
                      context.pop();
                    }
                  },
            child: c.isSaving
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
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: firstNameCtrl,
                decoration: const InputDecoration(labelText: "Vorname"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: lastNameCtrl,
                decoration: const InputDecoration(labelText: "Nachname"),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: aboutMeCtrl,
                maxLines: 6,
                decoration: const InputDecoration(labelText: "Über mich"),
              ),
              if (c.hasError) ...[
                const SizedBox(height: 12),
                Text(
                  c.errorMessage ?? "Fehler",
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
