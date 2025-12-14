import 'package:flutter/material.dart';

class TestShowModal extends StatefulWidget {
  const TestShowModal({super.key});

  @override
  State<TestShowModal> createState() => _TestShowModalState();
}

class _TestShowModalState extends State<TestShowModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Modal Bottom Sheet"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              constraints: BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: MediaQuery.of(context).size.height,
              ),
              builder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Text('Dies ist ein Test für ein Modal Bottom Sheet'),
                  ),
                );
              },
            );
          },
          child: const Text('Zeige Modal Bottom Sheet'),
        ),
      ),
    );
  }
}
