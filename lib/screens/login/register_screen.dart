import 'package:flutter/material.dart';
import 'package:frontend/providers/providers.dart';
import 'package:frontend/screens/screens.dart';
import 'package:frontend/services/services.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const SideBar(),
      appBar: AppBar(
        title: const Center(
          child: Text(""),
        ),
      ),
      body: AuthBadground(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 200,
            ),
            CardContainer(
              child: Column(
                children: [
                  const Text(
                    "Registrate",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => registerfromprovider(),
                    child: _RegisterForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: Text(
                      "Iniciar Session",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<registerfromprovider>(context);
    return Form(
      key: registerForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            onChanged: (value) => registerForm.name = value,
            decoration: InputDecoration(
              // hintText: "Nombre Completo",
              labelText: "Nombre Completo",
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 30),

          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => registerForm.email = value,
            decoration: InputDecoration(
              labelText: "Correo Electronico",
              prefixIcon: const Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 30),

          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => registerForm.password = value,
            decoration: InputDecoration(
              labelText: "Contraseña",
              prefixIcon: const Icon(Icons.password),
            ),
            validator: (value) {
              if (value != null && value.length >= 8) return null;
              return 'La contrasena es demasiado corta';
            },
          ),
          // const SizedBox(height: 30),
          // Text(
          //   "Repita Contraseña",
          // ),
          // TextFormField(
          //   autocorrect: false,
          //   obscureText: true,
          //   keyboardType: TextInputType.emailAddress,
          //   onChanged: (value) => registerForm.password = value,
          //   validator: (value) {
          //     if (value != null && value.length >= 8) return null;
          //     return 'La contrasena es demasiado corta';
          //   },
          // ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.blue,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                registerForm.isLoading ? 'Espere' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;
                    // await Future.delayed(const Duration(seconds: 2));

                    // //
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    // //
                    String respuesta = await authService.register(
                        registerForm.name,
                        registerForm.email,
                        registerForm.password);

                    // // print(respuesta);
                    if (respuesta == "correcto") {
                      registerForm.isLoading = false;
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    // print(registerForm.name +
                    //     " " +
                    //     registerForm.email +
                    //     " " +
                    //     registerForm.password);
                    // print(registerForm.email);
                    // print(registerForm.password);
                  },
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
