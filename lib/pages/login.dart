import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'cadastro.dart';
import 'home.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  
  Future<void> fazerLogin() async {

  if (
    emailController.text.isEmpty ||
    senhaController.text.isEmpty
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          "Preencha todos os campos",
        ),
      ),
    );

    return;
  }

  if (!emailController.text.contains("@")) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          "Digite um e-mail válido",
        ),
      ),
    );

    return;
  }

  try {

    final usuario =
        await DatabaseHelper.instance.login(

      emailController.text.trim(),

      senhaController.text.trim(),
    );

    if (usuario != null) {

      Navigator.push(

        context,

        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );

    } else {

      showDialog(

        context: context,

        builder: (context) {

          return AlertDialog(

            title: Text(
              "Conta não encontrada",
            ),

            content: Text(
              "Você ainda não possui uma conta.\nDeseja criar uma?",
            ),

            actions: [

              TextButton(

                onPressed: () {
                  Navigator.pop(context);
                },

                child: Text("Cancelar"),
              ),

              ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                  Navigator.push(

                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                          CadastroPage(),
                    ),
                  );
                },

                child: Text(
                  "Criar Conta",
                ),
              ),
            ],
          );
        },
      );
    }

  } catch (e) {

    print(e);

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          "Crie uma conta para continuar.",
        ),
      ),
    );
  }
}

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Padding(

        padding: EdgeInsets.all(25),

        child: Center(

          child: SingleChildScrollView(

            child: Column(

              children: [

                Icon(
                  Icons.task_alt,
                  size: 90,
                  color: Colors.green,
                ),

                SizedBox(height: 10),

                Text(
                  "TaskEasy",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Organize suas tarefas",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 40),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                ElevatedButton(

                  onPressed: fazerLogin,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroPage(),
                      ),
                    );
                  },
                  child: Text("Criar conta"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}