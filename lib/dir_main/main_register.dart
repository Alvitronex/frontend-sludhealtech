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
        title: Center(
          child: Column(
            children: [
              Text(
                'Salud Healtech',
                style: TextStyle(
                  color: Colors.grey.shade100,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Icon(
              Icons.person,
              size: 100,
              color: Colors.blue.shade800,
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ChangeNotifierProvider(
                create: (_) => registerfromprovider(),
                child: _RegisterForm(),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: const Text('¿Tienes una cuenta? Inicia aquí'),
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
              labelText: "Nombre Completo",
              prefixIcon: const Icon(Icons.person),
              prefixStyle: const TextStyle(
                  color: Color.fromARGB(255, 128, 93, 93),
                  fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Numero Telefonico',
              prefixIcon: const Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value != null &&
                  value.length >= 8 &&
                  value == registerForm.confirmedPassword) {
                return null;
              }
              if (value != registerForm.confirmedPassword) {
                return 'Las contraseñas no coinciden';
              }
              return 'La contraseña es demasiado corta';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => registerForm.confirmedPassword = value,
            decoration: InputDecoration(
              labelText: 'Confirmar Contraseña',
              prefixIcon: const Icon(Icons.confirmation_num),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value != registerForm.password) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
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
                registerForm.isLoading ? 'Espere' : 'Registrarse',
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

class registerfromproviders extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _confirmedPassword = '';
  String get confirmedPassword => _confirmedPassword;
  set confirmedPassword(String value) {
    _confirmedPassword = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

class registerfromprovider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _confirmedPassword = '';
  String get confirmedPassword => _confirmedPassword;
  set confirmedPassword(String value) {
    _confirmedPassword = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
