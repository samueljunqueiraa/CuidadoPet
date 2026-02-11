import 'dart:io';

/// Classe utilitária para entrada e validação de dados
class InputValidator {
  
  /// Lê uma string não vazia do console
  static String lerString(String mensagem) {
    while (true) {
      stdout.write(mensagem);
      final input = stdin.readLineSync()?.trim() ?? '';
      
      if (input.isNotEmpty) {
        return input;
      }
      
      print('❌ Por favor, digite algo válido!\n');
    }
  }

  /// Lê um número inteiro válido do console
  static int lerInteiro(String mensagem, {int? min, int? max}) {
    while (true) {
      stdout.write(mensagem);
      final input = stdin.readLineSync()?.trim() ?? '';
      
      if (input.isEmpty) {
        print('❌ Por favor, digite um número!\n');
        continue;
      }
      
      final numero = int.tryParse(input);
      if (numero == null) {
        print('❌ Por favor, digite um número válido!\n');
        continue;
      }
      
      if (min != null && numero < min) {
        print('❌ O número deve ser maior ou igual a $min!\n');
        continue;
      }
      
      if (max != null && numero > max) {
        print('❌ O número deve ser menor ou igual a $max!\n');
        continue;
      }
      
      return numero;
    }
  }

  /// Lê um número decimal válido do console
  static double lerDouble(String mensagem, {double? min}) {
    while (true) {
      stdout.write(mensagem);
      final input = stdin.readLineSync()?.trim() ?? '';
      
      if (input.isEmpty) {
        print('❌ Por favor, digite um valor!\n');
        continue;
      }
      
      // Substitui vírgula por ponto para aceitar formato brasileiro
      final inputFormatado = input.replaceAll(',', '.');
      final numero = double.tryParse(inputFormatado);
      
      if (numero == null) {
        print('❌ Por favor, digite um valor válido (ex: 10.50 ou 10,50)!\n');
        continue;
      }
      
      if (min != null && numero < min) {
        print('❌ O valor deve ser maior ou igual a ${min.toStringAsFixed(2)}!\n');
        continue;
      }
      
      return numero;
    }
  }

  /// Valida se um código existe em uma lista de códigos válidos
  static bool validarCodigo(int codigo, List<int> codigosValidos) {
    return codigosValidos.contains(codigo);
  }

  /// Confirma uma ação com o usuário
  static bool confirmarAcao(String mensagem) {
    while (true) {
      stdout.write('$mensagem (s/n): ');
      final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';
      
      if (input == 's' || input == 'sim') {
        return true;
      } else if (input == 'n' || input == 'nao' || input == 'não') {
        return false;
      }
      
      print('❌ Por favor, digite "s" para sim ou "n" para não!\n');
    }
  }

  /// Aguarda que o usuário pressione Enter para continuar
  static void aguardarEnter([String mensagem = 'Pressione Enter para continuar...']) {
    stdout.write('\n$mensagem');
    stdin.readLineSync();
  }

  /// Limpa a tela e aguarda um momento para melhor UX
  static void limparTelaComPausa([int milissegundos = 500]) {
    sleep(Duration(milliseconds: milissegundos));
    limparTela();
  }

  /// Exibe mensagem de transição entre telas
  static void transicaoTela(String mensagem) {
    print('\n🔄 $mensagem...');
    sleep(Duration(milliseconds: 800));
    limparTela();
  }

  /// Limpa a tela do console
  static void limparTela() {
    if (Platform.isWindows) {
      Process.runSync('cls', [], runInShell: true);
    } else {
      Process.runSync('clear', [], runInShell: true);
    }
  }

  /// Exibe uma linha separadora
  static void exibirSeparador([String caractere = '=', int tamanho = 50]) {
    print(caractere * tamanho);
  }

  /// Exibe título centralizado
  static void exibirTitulo(String titulo, [String caractere = '=']) {
    final tamanho = titulo.length + 4;
    exibirSeparador(caractere, tamanho);
    print('  $titulo  ');
    exibirSeparador(caractere, tamanho);
  }
}
