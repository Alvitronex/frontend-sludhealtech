import 'package:flutter/material.dart';
import 'package:frontend/components/components.dart';
// import 'package:frontend/components/components.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/screens/login/home.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _emailController = TextEditingController();
    // final TextEditingController _password = TextEditingController();
    // final _formkey = GlobalKey<FormState>();

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        title: const Center(
          child: Text("Medicina"),
        ),
      ),
      body: AuthBadground(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 300,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Iniciar Sesion",
                    // style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => loginformprovider(),
                    child: _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Bienvenido a tu app ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
          ]),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<loginformprovider>(context);
    return Form(
      key: loginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text("Correo Electronico"),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginForm.email = value,
          ),
          const SizedBox(height: 30),
          Text(
            "Contraseña",
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value != null && value.length >= 8) return null;
              return 'La contrasena es demasiado corta';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.blue,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
                    // await Future.delayed(const Duration(seconds: 2));

                    //
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    //
                    String respuesta = await authService.login(
                        loginForm.email, loginForm.password, 'movile');

                    // print(respuesta);
                    if (respuesta == "correcto") {
                      loginForm.isLoading = false;
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  },
            // onPressed: () {
            //   print('presionando');
            //   print(loginForm.email);
            //   print(loginForm.password);
            // }

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogoAlerta extends StatelessWidget {
  final String mensaje;
  const _DialogoAlerta({required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(mensaje),
    );
  }
}
