import '../models/cliente.dart';
import '../models/carrinho.dart';

/// Classe para gerenciar o histórico de atendimentos
class HistoricoAtendimento {
  final Cliente cliente;
  final List<String> itensComprados;
  final double valorTotal;
  final FormaPagamento formaPagamento;
  final DateTime dataHora;

  HistoricoAtendimento({
    required this.cliente,
    required this.itensComprados,
    required this.valorTotal,
    required this.formaPagamento,
  }) : dataHora = DateTime.now();

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('📋 HISTÓRICO - ${cliente.nome}');
    buffer.writeln('Data/Hora: ${_formatarDataHora()}');
    buffer.writeln('Atendimento: #${cliente.numeroAtendimento}');
    buffer.writeln('Itens comprados:');

    for (int i = 0; i < itensComprados.length; i++) {
      buffer.writeln('  ${i + 1}. ${itensComprados[i]}');
    }

    buffer.writeln('Forma de pagamento: ${formaPagamento.nome}');
    buffer.writeln('Total pago: R\$ ${valorTotal.toStringAsFixed(2)}');

    return buffer.toString();
  }

  String _formatarDataHora() {
    return '${dataHora.day.toString().padLeft(2, '0')}/'
        '${dataHora.month.toString().padLeft(2, '0')}/'
        '${dataHora.year} ${dataHora.hour.toString().padLeft(2, '0')}:'
        '${dataHora.minute.toString().padLeft(2, '0')}';
  }
}
