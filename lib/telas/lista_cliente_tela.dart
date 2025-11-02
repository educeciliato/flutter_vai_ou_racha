import 'package:flutter/material.dart';
import 'package:flutter_vai_ou_racha/model/cliente.dart';
import 'package:flutter_vai_ou_racha/telas/cadastro_cliente_tela.dart';

class ListaClientesTela extends StatefulWidget {
  @override
  State<ListaClientesTela> createState() => _ListaClientesTelaState();
}

class _ListaClientesTelaState extends State<ListaClientesTela> {
  Map<int, Cliente> clientes = <int, Cliente>{};

  void editarCliente(Cliente cliente) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroClienteTela(cliente: cliente),
      ),
    );

    if (resultado != null) {
      setState(() {
        clientes[resultado.id] = resultado;
      });
    }
  }

  void deletarCliente(int? id) {
    if (id == null) return;
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Confirmar'),
          content: Text('Deseja excluir este cliente?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Não')),
            TextButton(
              onPressed: () {
                setState(() {
                  clientes.remove(id);
                });
                Navigator.pop(ctx);
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: clientes.isEmpty
          ? Center(child: Text('Nenhum cliente cadastrado'))
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                Cliente cliente = clientes.values.elementAt(index);
                return ListTile(
                  title: Text(cliente.nome),
                  subtitle: Text(cliente.email),
                  leading: CircleAvatar(child: Text(cliente.nome[0])),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => editarCliente(cliente),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deletarCliente(cliente.id),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
