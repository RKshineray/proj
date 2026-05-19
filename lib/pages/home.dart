import 'package:flutter/material.dart';
import 'criar_tarefa.dart';
import 'perfil.dart';
import '../database/database_helper.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  List<Map<String, dynamic>> tarefas = [];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future carregarTarefas() async {

    final dados =
        await DatabaseHelper.instance
            .buscarTarefas();

    setState(() {
      tarefas = dados;
    });
  }

  Future excluirTarefa(int id) async {

    await DatabaseHelper.instance
        .deletarTarefa(id);

    carregarTarefas();
  }

  void editarTarefa(
    int id,
    String titulo,
  ) {

    TextEditingController controller =
        TextEditingController(
      text: titulo,
    );

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text("Editar tarefa"),

          content: TextField(
            controller: controller,
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: Text("Cancelar"),
            ),

            ElevatedButton(

              onPressed: () async {

                await DatabaseHelper.instance
                    .atualizarTarefa({

                  'id': id,
                  'titulo':
                      controller.text,
                });

                Navigator.pop(context);

                carregarTarefas();
              },

              child: Text("Salvar"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        backgroundColor: Colors.green,
      ),

      drawer: Drawer(

        child: ListView(
          children: [

            DrawerHeader(

              decoration: BoxDecoration(
                color: Colors.green,
              ),

              child: Center(

                child: Text(

                  "TaskEasy",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(

              leading: Icon(Icons.person),

              title: Text("Perfil"),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        PerfilPage(),
                  ),
                );
              },
            ),

            ListTile(

              leading: Icon(Icons.people),

              title: Text("Ver usuários"),

              onTap: () async {

                final usuarios =
                    await DatabaseHelper
                        .instance
                        .buscarUsuarios();

                print(usuarios);

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  SnackBar(
                    content: Text(
                      "Usuários mostrados no terminal",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: tarefas.isEmpty

          ? Center(

              child: Text(

                "Nenhuma tarefa criada",

                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )

          : ListView.builder(

              itemCount: tarefas.length,

              itemBuilder:
                  (context, index) {

                return Card(

                  margin: EdgeInsets.all(10),

                  child: ListTile(

                    leading: Icon(
                      Icons.task_alt,
                      color: Colors.green,
                    ),

                    title: Text(
                      tarefas[index]['titulo'],
                    ),

                    subtitle: Text(
                      tarefas[index]['categoria'],
                    ),

                    trailing: Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        IconButton(

                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),

                          onPressed: () {

                            editarTarefa(

                              tarefas[index]['id'],

                              tarefas[index]
                                  ['titulo'],
                            );
                          },
                        ),

                        IconButton(

                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),

                          onPressed: () {

                            excluirTarefa(
                              tarefas[index]['id'],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor: Colors.green,

        child: Icon(Icons.add),

        onPressed: () async {

          final novaTarefa =
              await Navigator.push(

            context,

            MaterialPageRoute(
              builder: (context) =>
                  CriarTarefaPage(),
            ),
          );

          if (novaTarefa != null) {

            carregarTarefas();
          }
        },
      ),
    );
  }
}