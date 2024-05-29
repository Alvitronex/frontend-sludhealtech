import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/components/components.dart';
import 'package:frontend/screens/login/home.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:provider/provider.dart';
// import 'package:frontend/screens/medicine/sugerente_medicine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage();

//Funcion para guardar token en cache, sea si se cierra la app siempre se mantiene activa la session

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   readToken();
  //   super.initState();
  // }

  // void readToken() async {
  //   String? token = await storage.read(key: 'token');
  //   Provider.of<AuthService>(context, listen: false).tryToken(token);
  //   print(token);
  // }

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
          child: Text("S'lud Healtech"),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(70),
              child: ListTile(
                leading: const Icon(Icons.home),
                title: Text(
                  "Comenzemos",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
