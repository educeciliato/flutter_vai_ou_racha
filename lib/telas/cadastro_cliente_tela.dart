import 'package:flutter/material.dart';
import 'package:flutter_vai_ou_racha/database/database_helper.dart';
import 'package:flutter_vai_ou_racha/model/cliente.dart';

class CadastroClienteTela extends StatefulWidget {
  final Cliente? cliente;

  CadastroClienteTela({this.cliente});

  @override
  State<CadastroClienteTela> createState() => _CadastroClienteTelaState();
}

class _CadastroClienteTelaState extends State<CadastroClienteTela> {
  final _formKey = GlobalKey<FormState>();
  late final nomeController = TextEditingController(text: widget.cliente?.nome);
  late final idadeController = TextEditingController(
    text: widget.cliente?.idade.toString(),
  );
  late final emailController = TextEditingController(
    text: widget.cliente?.email,
  );
  late final telefoneController = TextEditingController(
    text: widget.cliente?.telefone,
  );
  late final enderecoController = TextEditingController(
    text: widget.cliente?.endereco,
  );
  late final cpfController = TextEditingController(text: widget.cliente?.cpf);

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    enderecoController.dispose();
    cpfController.dispose();
    super.dispose();
  }

  Future<void> salvar() async {
    if (_formKey.currentState!.validate()) {
      Cliente cliente = Cliente(
        id: widget.cliente?.id,
        nome: nomeController.text,
        idade: int.parse(idadeController.text),
        email: emailController.text,
        telefone: telefoneController.text,
        cpf: cpfController.text,
        endereco: enderecoController.text,
      );
      Navigator.pop(context, cliente);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cliente == null ? 'Adicionar Cliente' : 'Editar Cliente',
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Digite o nome';
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Digite o E-mail!';
                  } else if (!val.contains('@') || !val.contains('.com')) {
                    return 'E-mail Inválido!';
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'digite o telelforne!';
                  } else if (val!.length < 10) {
                    return 'Telefone Inválido!';
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Digite o cpf!';
                  } else if (val!.length < 11) {
                    return 'CPF Inválido!';
                  }
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: Text('Cancelar', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: Text('Salvar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
