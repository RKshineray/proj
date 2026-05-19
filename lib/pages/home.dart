import 'package:flutter/material.dart';
import 'criar_tarefa.dart';
import 'perfil.dart';
import '../database/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> tarefas = [];

  void excluirTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  void editarTarefa(int index) {

    TextEditingController controller =
        TextEditingController(text: tarefas[index]);

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
              onPressed: () {

                setState(() {
                  tarefas[index] = controller.text;
                });

                Navigator.pop(context);
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
              fontWeight: FontWeight.bold,
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
              builder: (context) => PerfilPage(),
            ),
          );
        },
      ),

      ListTile(
        leading: Icon(Icons.people),
        title: Text("Ver usuários"),

        onTap: () async {

          final usuarios =
              await DatabaseHelper.instance
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
                style: TextStyle(fontSize: 18),
              ),
            )

          : ListView.builder(
              itemCount: tarefas.length,

              itemBuilder: (context, index) {

                return Card(
                  margin: EdgeInsets.all(10),

                  child: ListTile(

                    leading: Icon(
                      Icons.task_alt,
                      color: Colors.green,
                    ),

                    title: Text(tarefas[index]),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [

                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),

                          onPressed: () {
                            editarTarefa(index);
                          },
                        ),

                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),

                          onPressed: () {
                            excluirTarefa(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,

        child: Icon(Icons.add),

        onPressed: () async {

          final novaTarefa = await Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) => CriarTarefaPage(),
            ),
          );

          if (novaTarefa != null) {

            setState(() {
              tarefas.add(novaTarefa);
            });
          }
        },
      ),
    );
  }
}