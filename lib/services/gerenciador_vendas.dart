import '../models/cliente.dart';
import '../models/carrinho.dart';
import '../models/historico_atendimento.dart';

/// Classe para gerenciar as vendas e relatórios do sistema
class GerenciadorVendas {
  static int _proximoNumeroAtendimento = 1;
  static double _totalFaturado = 0.0;
  static final List<HistoricoAtendimento> _historico = [];

  /// Retorna o próximo número de atendimento
  static int get proximoNumeroAtendimento => _proximoNumeroAtendimento;

  /// Retorna total de clientes atendidos
  static int get totalClientesAtendidos => _proximoNumeroAtendimento - 1;

  /// Retorna valor total faturado
  static double get totalFaturado => _totalFaturado;

  /// Retorna histórico de atendimentos
  static List<HistoricoAtendimento> get historico => List.unmodifiable(_historico);

  /// Registra uma nova venda
  static void registrarVenda({
    required Cliente cliente,
    required Carrinho carrinho,
    required FormaPagamento formaPagamento,
  }) {
    final valorTotal = carrinho.getTotal(formaPagamento);
    final itensComprados = carrinho.itens.map((item) => item.nome).toList();

    // Adiciona ao histórico
    final atendimento = HistoricoAtendimento(
      cliente: cliente,
      itensComprados: itensComprados,
      valorTotal: valorTotal,
      formaPagamento: formaPagamento,
    );
    _historico.add(atendimento);

    // Atualiza totais
    _totalFaturado += valorTotal;
    _proximoNumeroAtendimento++;
  }

  /// Registra venda da área restrita (funcionários)
  static void registrarVendaRestrita({
    required String nomeCliente,
    required double valor,
    required FormaPagamento formaPagamento,
  }) {
    final cliente = Cliente(
      nome: nomeCliente,
      numeroAtendimento: _proximoNumeroAtendimento,
    );

    final atendimento = HistoricoAtendimento(
      cliente: cliente,
      itensComprados: ['Venda registrada pela área restrita'],
      valorTotal: valor,
      formaPagamento: formaPagamento,
    );
    _historico.add(atendimento);

    _totalFaturado += valor;
    _proximoNumeroAtendimento++;
  }

  /// Gera relatório do dia
  static String gerarRelatorioFinal() {
    final buffer = StringBuffer();
    buffer.writeln('📊 RELATÓRIO FINAL DO DIA');
    buffer.writeln('${'=' * 40}');
    buffer.writeln('Data: ${_formatarDataAtual()}');
    buffer.writeln('Total de clientes atendidos: $totalClientesAtendidos');
    buffer.writeln('Valor total faturado: R\$ ${totalFaturado.toStringAsFixed(2)}');
    
    if (_historico.isNotEmpty) {
      buffer.writeln('\n💰 RESUMO POR FORMA DE PAGAMENTO:');
      final resumoPagamento = _gerarResumoPagamento();
      resumoPagamento.forEach((forma, dados) {
        buffer.writeln('${forma.nome}: ${dados['quantidade']} vendas - R\$ ${dados['valor'].toStringAsFixed(2)}');
      });

      buffer.writeln('\n📈 TICKET MÉDIO:');
      final ticketMedio = totalFaturado / totalClientesAtendidos;
      buffer.writeln('R\$ ${ticketMedio.toStringAsFixed(2)}');
    }
    
    buffer.writeln('${'=' * 40}');
    buffer.writeln('Obrigado por usar o Sistema Cuidapet! 🐾');
    
    return buffer.toString();
  }

  /// Retorna histórico de um cliente específico
  static List<HistoricoAtendimento> obterHistoricoCliente(String nomeCliente) {
    return _historico
        .where((atendimento) => atendimento.cliente.nome.toLowerCase() == nomeCliente.toLowerCase())
        .toList();
  }

  static String _formatarDataAtual() {
    final agora = DateTime.now();
    return '${agora.day.toString().padLeft(2, '0')}/'
           '${agora.month.toString().padLeft(2, '0')}/'
           '${agora.year}';
  }

  static Map<FormaPagamento, Map<String, dynamic>> _gerarResumoPagamento() {
    final resumo = <FormaPagamento, Map<String, dynamic>>{};
    
    for (final forma in FormaPagamento.values) {
      resumo[forma] = {'quantidade': 0, 'valor': 0.0};
    }

    for (final atendimento in _historico) {
      final forma = atendimento.formaPagamento;
      resumo[forma]!['quantidade']++;
      resumo[forma]!['valor'] += atendimento.valorTotal;
    }

    return resumo;
  }

  /// Reseta todos os dados (para teste ou início de novo dia)
  static void resetarDados() {
    _proximoNumeroAtendimento = 1;
    _totalFaturado = 0.0;
    _historico.clear();
  }
}
