import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'cadastro.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> fazerLogin() async {

  final usuarios =
      await DatabaseHelper.instance
          .buscarUsuarios();

  bool usuarioEncontrado = false;

  for (var usuario in usuarios) {

    if (
      usuario['nome']
              .toString()
              .trim() ==
          nomeController.text.trim() &&

      usuario['email']
              .toString()
              .trim() ==
          emailController.text.trim() &&

      usuario['senha']
              .toString()
              .trim() ==
          senhaController.text.trim()
    ) {

      usuarioEncontrado = true;
      break;
    }
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

  if (usuarioEncontrado) {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );

  } else {

    await showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text(
            "Usuário não encontrado",
          ),

          content: Text(
            "Você precisa criar uma conta.",
          ),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(context);
              },

              child: Text("Fechar"),
            ),

            ElevatedButton(
              onPressed: () {

                Navigator.pop(context);

                Future.delayed(
                  Duration(milliseconds: 300),

                  () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                            CadastroPage(),
                      ),
                    );
                  },
                );
              },

              child: Text("Cadastrar"),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(25),

        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 80),

              Icon(
                Icons.task_alt,
                size: 100,
                color: Colors.green,
              ),

              SizedBox(height: 20),

              Text(
                "TaskEasy",

                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Organize suas tarefas",
                style: TextStyle(fontSize: 18),
              ),

              SizedBox(height: 50),

              TextField(
                controller: nomeController,

                decoration: InputDecoration(
                  hintText: "Nome",
                  prefixIcon: Icon(Icons.person),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: emailController,

                decoration: InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: senhaController,
                obscureText: true,

                decoration: InputDecoration(
                  hintText: "Senha",
                  prefixIcon: Icon(Icons.lock),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 30),

              ElevatedButton(

                onPressed: fazerLogin,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize:
                      Size(double.infinity, 55),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),

                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 20),

              TextButton(
                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                          CadastroPage(),
                    ),
                  );
                },

                child: Text("Criar Conta"),
              )
            ],
          ),
        ),
      ),
    );
  }
}