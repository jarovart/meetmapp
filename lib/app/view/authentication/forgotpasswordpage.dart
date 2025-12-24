import 'package:flutter/material.dart';
import 'package:meetmaap/app/repositories/authrepository.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final _emailCtrl = TextEditingController();
  bool _sent = false;

  Future<void> _submit() async {
    await AuthRepository.forgotPassword(_emailCtrl.text.trim());
    setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Passwort zurücksetzen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          if (!_sent)
            TextField(
              controller: _emailCtrl,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(labelText: 'E-Mail'),
            ),
          const SizedBox(height: 16),
          if (_sent) const Text('📩 Reset-Link wurde versendet'),
          if (!_sent)
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Link senden'),
            ),
        ],
      ),
    );
  }
}
