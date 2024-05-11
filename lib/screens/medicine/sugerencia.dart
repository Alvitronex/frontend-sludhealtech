import 'package:flutter/material.dart';
import 'package:frontend/screens/screens.dart';

class Sugerencia extends StatelessWidget {
  const Sugerencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomeScreen())),
        ),
      ),
      body: const SugerenteMedicine(
        child: Column(
          children: [
            SizedBox(
              height: 400,
            ),
            Text("data"),
          ],
        ),
      ),
    );
  }
}
