import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class PerfilPage extends StatefulWidget {
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  String nome = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  Future carregarUsuario() async {

    final usuarios =
        await DatabaseHelper.instance
            .buscarUsuarios();

    if (usuarios.isNotEmpty) {

      setState(() {

        nome = usuarios.last['nome'];
        email = usuarios.last['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: Colors.green,
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,

              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            Text(
              nome,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}