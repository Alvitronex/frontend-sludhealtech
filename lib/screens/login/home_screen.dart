import 'package:flutter/material.dart';
import 'package:frontend/components/components.dart';
// import 'package:frontend/screens/medicine/sugerente_medicine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.abc),
        //   onPressed: () => Navigator.push(context,
        //       MaterialPageRoute(builder: (_) => const SugerenteMedicine())),
        // ),
        title: const Center(
          child: Text("Home Screens"),
        ),
      ),
      body: const Center(
        child: Column(),
      ),
    );
  }
}
