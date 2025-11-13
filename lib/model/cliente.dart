class Cliente {
  final int? id;
  final String nome;
  final int idade;
  final String email;
  final String telefone;
  final String endereco;
  final String cpf;
  final double peso;

  Cliente({
    this.id,
    required this.nome,
    required this.idade,
    required this.email,
    required this.telefone,
    required this.endereco,
    required this.cpf,
    required this.peso,
  });
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      email: json['email'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      cpf: json['cpf'],
      peso: (json['peso'] as num?)?.toDouble() ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'cpf': cpf,
      'peso': peso,
    };
  }

  Cliente copyWith({
    int? id,
    String? nome,
    int? idade,
    String? email,
    String? telefone,
    String? endereco,
    String? cpf,
    double? peso,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cpf: cpf ?? this.cpf,
      peso: peso ?? this.peso,
    );
  }
}
