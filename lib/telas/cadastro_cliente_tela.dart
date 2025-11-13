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
    text: widget.cliente?.idade?.toString(),
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
  late final pesoController = TextEditingController(
    text: widget.cliente?.peso?.toString(),
  );

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    enderecoController.dispose();
    cpfController.dispose();
    pesoController.dispose();
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
        peso: double.parse(pesoController.text),
      );

      final db = DatabaseHelper.instance;

      if (widget.cliente == null) {
        await db.create(cliente);
      } else {
        await db.update(cliente);
      }

      Navigator.pop(context, true);
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
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Digite o nome' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: idadeController,
                decoration: InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Digite a idade' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Digite o e-mail!';
                  } else if (!val.contains('@') || !val.contains('.')) {
                    return 'E-mail inválido!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Digite o telefone!' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Digite o CPF!' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: enderecoController,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Digite o endereço!' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: pesoController,
                decoration: InputDecoration(
                  labelText: 'Peso',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Digite o peso' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
