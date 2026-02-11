/// Classe abstrata base para produtos e serviços
abstract class Item {
  final int codigo;
  final String nome;
  final double preco;

  Item({required this.codigo, required this.nome, required this.preco});

  @override
  String toString() {
    return 'Código: $codigo | $nome - R\$ ${preco.toStringAsFixed(2)}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo;

  @override
  int get hashCode => codigo.hashCode;
}
