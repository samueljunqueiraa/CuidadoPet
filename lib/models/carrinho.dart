import 'item.dart';

/// Enum para formas de pagamento disponíveis
enum FormaPagamento {
  dinheiro('Dinheiro', 0.10),
  cartaoCredito('Cartão de Crédito', 0.0),
  cartaoDebito('Cartão de Débito', 0.05),
  pix('PIX', 0.08);

  const FormaPagamento(this.nome, this.desconto);

  final String nome;
  final double desconto; // percentual de desconto (0.10 = 10%)

  @override
  String toString() => nome;

  /// Retorna o percentual de desconto formatado
  String getDescontoFormatado() {
    return '${(desconto * 100).toStringAsFixed(0)}%';
  }
}

/// Classe que representa o carrinho de compras
class Carrinho {
  static const int maxItens = 3;
  final List<Item> _itens = [];

  /// Retorna lista imutável dos itens
  List<Item> get itens => List.unmodifiable(_itens);

  /// Retorna quantidade de itens no carrinho
  int get quantidade => _itens.length;

  /// Verifica se o carrinho está vazio
  bool get isEmpty => _itens.isEmpty;

  /// Verifica se o carrinho está cheio
  bool get isFull => _itens.length >= maxItens;

  /// Adiciona item ao carrinho
  bool adicionarItem(Item item) {
    if (isFull) {
      return false;
    }

    // Verifica se o item já existe no carrinho
    if (_itens.contains(item)) {
      return false;
    }

    _itens.add(item);
    return true;
  }

  /// Remove item do carrinho
  bool removerItem(int codigo) {
    final tamanhoInicial = _itens.length;
    _itens.removeWhere((item) => item.codigo == codigo);
    return _itens.length < tamanhoInicial;
  }

  /// Calcula subtotal do carrinho
  double getSubtotal() {
    return _itens.fold(0.0, (total, item) => total + item.preco);
  }

  /// Calcula desconto baseado na forma de pagamento
  double getDesconto(FormaPagamento formaPagamento) {
    return getSubtotal() * formaPagamento.desconto;
  }

  /// Calcula total com desconto
  double getTotal(FormaPagamento formaPagamento) {
    return getSubtotal() - getDesconto(formaPagamento);
  }

  /// Limpa o carrinho
  void limpar() {
    _itens.clear();
  }

  /// Retorna representação em string do carrinho
  @override
  String toString() {
    if (isEmpty) {
      return 'Carrinho vazio';
    }

    final buffer = StringBuffer();
    buffer.writeln('🛒 CARRINHO DE COMPRAS ($quantidade/$maxItens itens)');
    buffer.writeln('${'=' * 50}');

    for (int i = 0; i < _itens.length; i++) {
      buffer.writeln('${i + 1}. ${_itens[i]}');
      if (i < _itens.length - 1) buffer.writeln();
    }

    buffer.writeln('${'=' * 50}');
    buffer.writeln('SUBTOTAL: R\$ ${getSubtotal().toStringAsFixed(2)}');

    return buffer.toString();
  }

  /// Retorna resumo formatado para finalização
  String getResumoFinalizacao(FormaPagamento formaPagamento) {
    final buffer = StringBuffer();
    buffer.writeln('🧾 RESUMO DO PEDIDO');
    buffer.writeln('${'=' * 30}');

    for (int i = 0; i < _itens.length; i++) {
      final item = _itens[i];
      buffer.writeln('${i + 1}. ${item.nome}');
      buffer.writeln('    R\$ ${item.preco.toStringAsFixed(2)}');
    }

    buffer.writeln('${'=' * 30}');
    buffer.writeln('Subtotal: R\$ ${getSubtotal().toStringAsFixed(2)}');
    buffer.writeln('Forma de pagamento: ${formaPagamento.nome}');

    final desconto = getDesconto(formaPagamento);
    if (desconto > 0) {
      buffer.writeln(
          'Desconto (${formaPagamento.getDescontoFormatado()}): -R\$ ${desconto.toStringAsFixed(2)}');
    }

    buffer.writeln('${'=' * 30}');
    buffer.writeln('TOTAL: R\$ ${getTotal(formaPagamento).toStringAsFixed(2)}');

    return buffer.toString();
  }
}
