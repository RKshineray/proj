import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class CadastroPage extends StatelessWidget {

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            SizedBox(height: 20),

            TextField(
              controller: nomeController,

              decoration: InputDecoration(
                hintText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: emailController,

              decoration: InputDecoration(
                hintText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: senhaController,
              obscureText: true,

              decoration: InputDecoration(
                hintText: "Senha",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(

              onPressed: () async {

                await DatabaseHelper.instance
                    .criarUsuario({

                  'nome': nomeController.text,
                  'email': emailController.text,
                  'senha': senhaController.text,
                });

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  SnackBar(
                    content:
                        Text("Usuário cadastrado"),
                  ),
                );

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize:
                    Size(double.infinity, 50),
              ),

              child: Text("Cadastrar"),
            )
          ],
        ),
      ),
    );
  }
}