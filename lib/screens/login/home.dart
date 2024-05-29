import 'package:flutter/material.dart';
import 'package:frontend/components/components.dart';


class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Center(
          child: Text("Medicina"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Center(
          child: Column(children: [
            Text(
              "Bienvenido",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade400,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
