import 'item.dart';

/// Classe que representa um serviço oferecido pela loja
class Servico extends Item {
  final String duracao;
  final String descricao;
  final bool requerAgendamento;

  Servico({
    required super.codigo,
    required super.nome,
    required super.preco,
    required this.duracao,
    required this.descricao,
    this.requerAgendamento = true,
  });

  @override
  String toString() {
    return 'SERVIÇO - ${super.toString()}\n'
        '  Duração: $duracao\n'
        '  Descrição: $descricao\n'
        '  Agendamento: ${requerAgendamento ? 'Necessário' : 'Não necessário'}';
  }

  /// Método para obter lista de serviços disponíveis
  static List<Servico> getServicosDisponiveis() {
    return [
      Servico(
        codigo: 201,
        nome: 'Banho e Tosa Completa',
        preco: 45.00,
        duracao: '2h',
        descricao: 'Banho, tosa higiênica, corte de unhas e limpeza de ouvidos',
      ),
      Servico(
        codigo: 202,
        nome: 'Consulta Veterinária',
        preco: 80.00,
        duracao: '30min',
        descricao: 'Consulta clínica geral com veterinário especializado',
      ),
      Servico(
        codigo: 203,
        nome: 'Vacinação Múltipla',
        preco: 65.00,
        duracao: '15min',
        descricao: 'Aplicação de vacina múltipla (V8 ou V10)',
      ),
    ];
  }
}
