/// Classe que representa um cliente do sistema
class Cliente {
  final String nome;
  final DateTime dataAtendimento;
  final int numeroAtendimento;

  Cliente({
    required this.nome,
    required this.numeroAtendimento,
  }) : dataAtendimento = DateTime.now();

  @override
  String toString() {
    return 'Cliente: $nome (Atendimento #$numeroAtendimento)';
  }

  /// Retorna saudação personalizada baseada no horário
  String getSaudacaoPersonalizada() {
    final hora = dataAtendimento.hour;
    String saudacao;

    if (hora >= 5 && hora < 12) {
      saudacao = 'Bom dia';
    } else if (hora >= 12 && hora < 18) {
      saudacao = 'Boa tarde';
    } else {
      saudacao = 'Boa noite';
    }

    return '$saudacao, $nome! Seja bem-vindo(a) à Cuidapet! 🐾';
  }

  /// Retorna informações formatadas do atendimento
  String getInfoAtendimento() {
    final dataFormatada = '${dataAtendimento.day.toString().padLeft(2, '0')}/'
        '${dataAtendimento.month.toString().padLeft(2, '0')}/'
        '${dataAtendimento.year}';
    final horaFormatada = '${dataAtendimento.hour.toString().padLeft(2, '0')}:'
        '${dataAtendimento.minute.toString().padLeft(2, '0')}';

    return 'Atendimento #$numeroAtendimento - $dataFormatada às $horaFormatada';
  }
}
