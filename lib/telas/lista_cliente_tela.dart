import 'package:flutter/material.dart';
import 'package:flutter_vai_ou_racha/model/cliente.dart';
import 'package:flutter_vai_ou_racha/database/database_helper.dart';
import 'package:flutter_vai_ou_racha/telas/cadastro_cliente_tela.dart';

class ListaClientesTela extends StatefulWidget {
  @override
  State<ListaClientesTela> createState() => _ListaClientesTelaState();
}

class _ListaClientesTelaState extends State<ListaClientesTela> {
  List<Cliente> clientes = [];

  @override
  void initState() {
    super.initState();
    carregarClientes();
  }

  Future<void> carregarClientes() async {
    final db = DatabaseHelper.instance;
    final lista = await db.readAllClientes();
    setState(() {
      clientes = lista;
    });
  }

  Future<void> adicionarCliente() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroClienteTela()),
    );

    if (resultado == true) {
      carregarClientes();
    }
  }

  Future<void> editarCliente(Cliente cliente) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroClienteTela(cliente: cliente),
      ),
    );

    if (resultado == true) {
      carregarClientes();
    }
  }

  Future<void> deletarCliente(int id) async {
    final db = DatabaseHelper.instance;
    await db.delete(id);
    carregarClientes();
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
                Cliente cliente = clientes[index];
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
                        onPressed: () => deletarCliente(cliente.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
