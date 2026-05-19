import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class CriarTarefaPage extends StatefulWidget {

  @override
  State<CriarTarefaPage> createState() =>
      _CriarTarefaPageState();
}

class _CriarTarefaPageState
    extends State<CriarTarefaPage> {

  TextEditingController tituloController =
      TextEditingController();

  TextEditingController descricaoController =
      TextEditingController();

  TextEditingController categoriaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Nova Tarefa"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: tituloController,

              decoration: InputDecoration(
                hintText: "Título da tarefa",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: descricaoController,
              maxLines: 4,

              decoration: InputDecoration(
                hintText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: categoriaController,

              decoration: InputDecoration(
                hintText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(

              onPressed: () async {

                if (tituloController
                    .text
                    .isNotEmpty) {

                  await DatabaseHelper.instance
                      .criarTarefa({

                    'titulo':
                        tituloController.text.trim(),

                    'descricao':
                        descricaoController.text.trim(),

                    'categoria':
                        categoriaController.text.trim(),
                  });

                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize:
                    Size(double.infinity, 50),
              ),

              child: Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}