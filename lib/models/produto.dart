import 'item.dart';

/// Classe que representa um produto da loja
class Produto extends Item {
  final String categoria;
  final String descricao;

  Produto({
    required super.codigo,
    required super.nome,
    required super.preco,
    required this.categoria,
    required this.descricao,
  });

  @override
  String toString() {
    return 'PRODUTO - ${super.toString()}\n'
        '  Categoria: $categoria\n'
        '  Descrição: $descricao';
  }

  /// Método para criar produtos em promoção
  static List<Produto> getProdutosPromocao() {
    return [
      Produto(
        codigo: 101,
        nome: 'Ração Premium Cães 15kg',
        preco: 89.90,
        categoria: 'Alimentação',
        descricao: 'Ração completa e balanceada para cães adultos',
      ),
      Produto(
        codigo: 102,
        nome: 'Brinquedo Corda Colorida',
        preco: 15.50,
        categoria: 'Brinquedos',
        descricao: 'Brinquedo resistente para cães de todos os tamanhos',
      ),
      Produto(
        codigo: 103,
        nome: 'Shampoo Antipulgas 500ml',
        preco: 24.90,
        categoria: 'Higiene',
        descricao: 'Shampoo com ação antipulgas e carrapaticida',
      ),
      Produto(
        codigo: 104,
        nome: 'Casa de Madeira Média',
        preco: 199.00,
        categoria: 'Acessórios',
        descricao: 'Casa de madeira tratada para cães de porte médio',
      ),
    ];
  }
}
