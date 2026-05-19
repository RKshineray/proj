import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class CadastroPage
    extends StatefulWidget {

  @override
  State<CadastroPage> createState() =>
      _CadastroPageState();
}

class _CadastroPageState
    extends State<CadastroPage> {

  final nomeController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final senhaController =
      TextEditingController();

  Future<void> cadastrar() async {

  if (
    nomeController.text.isEmpty ||
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

  if (
    !emailController.text.contains("@")
  ) {

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

    final usuarios =
        await DatabaseHelper.instance
            .buscarUsuarios();

    bool emailJaExiste = false;

    for (var usuario in usuarios) {

      if (
        usuario['email']
            .toString()
            .trim() ==

        emailController.text
            .trim()
      ) {

        emailJaExiste = true;
        break;
      }
    }

    if (emailJaExiste) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            "Este e-mail já está cadastrado",
          ),
        ),
      );

      return;
    }

    await DatabaseHelper.instance
        .criarUsuario({

      'nome':
          nomeController.text.trim(),

      'email':
          emailController.text.trim(),

      'senha':
          senhaController.text.trim(),
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          "Usuário cadastrado com sucesso",
        ),
      ),
    );

    Navigator.pop(context);

  } catch (e) {

  ScaffoldMessenger.of(context)
      .showSnackBar(

    SnackBar(
      content: Text(
        e.toString(),
      ),
    ),
  );

  print(e);
}
}

  @override
  void dispose() {

    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text("Cadastro"),

        backgroundColor:
            Colors.green,
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            SizedBox(height: 20),

            TextField(

              controller:
                  nomeController,

              decoration:
                  InputDecoration(

                hintText: "Nome",

                border:
                    OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(

              controller:
                  emailController,

              decoration:
                  InputDecoration(

                hintText: "E-mail",

                border:
                    OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(

              controller:
                  senhaController,

              obscureText: true,

              decoration:
                  InputDecoration(

                hintText: "Senha",

                border:
                    OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(

              onPressed: cadastrar,

              style:
                  ElevatedButton
                      .styleFrom(

                backgroundColor:
                    Colors.green,

                minimumSize:
                    Size(
                  double.infinity,
                  50,
                ),
              ),

              child:
                  Text("Cadastrar"),
            )
          ],
        ),
      ),
    );
  }
}