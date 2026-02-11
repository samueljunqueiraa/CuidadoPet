import '../lib/models/cliente.dart';
import '../lib/models/produto.dart';
import '../lib/models/servico.dart';
import '../lib/models/carrinho.dart';
import '../lib/models/item.dart';
import '../lib/services/gerenciador_vendas.dart';
import '../lib/utils/input_validator.dart';
import '../lib/utils/gerador_recibo.dart';

/// Classe principal do Sistema de Auto Atendimento Cuidapet
class SistemaCuidapet {
  static const String senhaRestrita = 'cuidapetrestrito';

  /// Lista de produtos em promoção
  static final List<Produto> produtos = Produto.getProdutosPromocao();

  /// Lista de serviços disponíveis
  static final List<Servico> servicos = Servico.getServicosDisponiveis();

  /// Executa o sistema principal
  static void executar() {
    _exibirBoasVindas();

    while (true) {
      final nomeCliente = InputValidator.lerString('\n👤 Digite seu nome: ');
      final cliente = Cliente(
        nome: nomeCliente,
        numeroAtendimento: GerenciadorVendas.proximoNumeroAtendimento,
      );

      _executarAtendimentoCliente(cliente);

      // Pergunta se deseja atender outro cliente
      print('\n');
      if (!InputValidator.confirmarAcao('🔄 Deseja atender outro cliente?')) {
        break;
      }

      InputValidator.limparTela();
    }

    // Exibe relatório final
    InputValidator.limparTela();
    print(GerenciadorVendas.gerarRelatorioFinal());
  }

  /// Exibe tela de boas-vindas
  static void _exibirBoasVindas() {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('SISTEMA DE AUTO ATENDIMENTO CUIDAPET', '🐾');
    print('\n🏪 Bem-vindo à Cuidapet!');
    print('Aqui você encontra tudo para o seu pet com carinho e qualidade.');
    print('Vamos começar seu atendimento personalizado! ✨');
  }

  /// Executa o atendimento de um cliente específico
  static void _executarAtendimentoCliente(Cliente cliente) {
    InputValidator.limparTela();
    print(cliente.getSaudacaoPersonalizada());
    print(cliente.getInfoAtendimento());

    final carrinho = Carrinho();

    while (true) {
      _exibirMenuPrincipal(carrinho);
      final opcao =
          InputValidator.lerInteiro('\n🎯 Escolha uma opção: ', min: 0, max: 5);

      switch (opcao) {
        case 1:
          _exibirPromocoes(carrinho);
          InputValidator.limparTela();
          print(cliente.getSaudacaoPersonalizada());
          break;
        case 2:
          _exibirServicos(carrinho);
          InputValidator.limparTela();
          print(cliente.getSaudacaoPersonalizada());
          break;
        case 3:
          _listarCarrinho(carrinho);
          InputValidator.limparTela();
          print(cliente.getSaudacaoPersonalizada());
          break;
        case 4:
          if (_finalizarCarrinho(cliente, carrinho)) {
            return; // Sai do atendimento após finalizar
          }
          InputValidator.limparTela();
          print(cliente.getSaudacaoPersonalizada());
          break;
        case 5:
          _acessarAreaRestrita();
          InputValidator.limparTela();
          print(cliente.getSaudacaoPersonalizada());
          break;
        case 0:
          InputValidator.limparTela();
          print('\n👋 Obrigado por visitar a Cuidapet, ${cliente.nome}!');
          print('Esperamos vê-lo novamente em breve! 🐾❤️');
          InputValidator.aguardarEnter();
          return;
        default:
          print('\n❌ Opção inválida!');
          InputValidator.aguardarEnter('\nPressione Enter para continuar...');
      }
    }
  }

  /// Exibe o menu principal
  static void _exibirMenuPrincipal([Carrinho? carrinho]) {
    print('\n');
    InputValidator.exibirSeparador('=', 40);
    print('           🐾 MENU PRINCIPAL 🐾');
    InputValidator.exibirSeparador('=', 40);

    // Mostra status do carrinho se existir
    if (carrinho != null && !carrinho.isEmpty) {
      print(
          '🛒 Carrinho: ${carrinho.quantidade}/${Carrinho.maxItens} itens | Subtotal: R\$ ${carrinho.getSubtotal().toStringAsFixed(2)}');
      InputValidator.exibirSeparador('-', 40);
    }

    print('1. 🏷️  Ver promoções de produtos');
    print('2. 🛁  Solicitar serviços');
    print('3. 🛒  Listar carrinho de compras');
    print('4. ✅  Finalizar carrinho');
    print('5. 🔒  Área restrita (funcionários)');
    print('0. 🚪  Sair');
    InputValidator.exibirSeparador('=', 40);
  }

  /// Exibe promoções de produtos
  static void _exibirPromocoes(Carrinho carrinho) {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('PROMOÇÕES DE PRODUTOS', '🏷️');

    print('\n📦 Produtos em promoção:');
    print('');

    for (int i = 0; i < produtos.length; i++) {
      print('${i + 1}. ${produtos[i]}');
      if (i < produtos.length - 1) print('');
    }

    print('\n');
    if (InputValidator.confirmarAcao(
        '💡 Deseja adicionar algum produto ao carrinho?')) {
      _adicionarItemAoCarrinho(carrinho, produtos);
    }

    InputValidator.aguardarEnter();
  }

  /// Exibe serviços disponíveis
  static void _exibirServicos(Carrinho carrinho) {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('SERVIÇOS DISPONÍVEIS', '🛁');

    print('\n🔧 Nossos serviços:');
    print('');

    for (int i = 0; i < servicos.length; i++) {
      print('${i + 1}. ${servicos[i]}');
      if (i < servicos.length - 1) print('');
    }

    print('\n');
    if (InputValidator.confirmarAcao(
        '💡 Deseja adicionar algum serviço ao carrinho?')) {
      _adicionarItemAoCarrinho(carrinho, servicos);
    }

    InputValidator.aguardarEnter();
  }

  /// Adiciona item ao carrinho
  static void _adicionarItemAoCarrinho(
      Carrinho carrinho, List<Item> itensDisponiveis) {
    if (carrinho.isFull) {
      print(
          '\n❌ Seu carrinho já está cheio! (máximo ${Carrinho.maxItens} itens)');
      InputValidator.aguardarEnter();
      return;
    }

    // Cria lista de códigos válidos
    final codigosValidos = itensDisponiveis.map((item) => item.codigo).toList();

    print('\n🔢 Códigos disponíveis: ${codigosValidos.join(', ')}');
    final codigo = InputValidator.lerInteiro('\n🎯 Digite o código do item: ');

    if (!InputValidator.validarCodigo(codigo, codigosValidos)) {
      print('\n❌ Código inválido! Tente novamente.');
      InputValidator.aguardarEnter();
      return;
    }

    // Encontra o item
    final item = itensDisponiveis.firstWhere((item) => item.codigo == codigo);

    // Tenta adicionar ao carrinho
    if (carrinho.adicionarItem(item)) {
      print('\n✅ ${item.nome} adicionado ao carrinho!');
      print('📊 Carrinho: ${carrinho.quantidade}/${Carrinho.maxItens} itens');

      if (!carrinho.isFull &&
          InputValidator.confirmarAcao('\n🔄 Deseja adicionar outro item?')) {
        _adicionarItemAoCarrinho(carrinho, itensDisponiveis);
      }
    } else {
      print('\n❌ Este item já está no seu carrinho!');
      InputValidator.aguardarEnter();
    }
  }

  /// Lista itens do carrinho
  static void _listarCarrinho(Carrinho carrinho) {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('SEU CARRINHO', '🛒');

    if (carrinho.isEmpty) {
      print('\n📭 Seu carrinho está vazio!');
      print(
          '💡 Adicione produtos ou serviços usando as opções 1 ou 2 do menu.');
    } else {
      print('\n${carrinho}');

      if (InputValidator.confirmarAcao('\n🗑️ Deseja remover algum item?')) {
        _removerItemDoCarrinho(carrinho);
      }
    }

    InputValidator.aguardarEnter();
  }

  /// Remove item do carrinho
  static void _removerItemDoCarrinho(Carrinho carrinho) {
    if (carrinho.isEmpty) return;

    print(
        '\n🔢 Códigos no carrinho: ${carrinho.itens.map((item) => item.codigo).join(', ')}');
    final codigo =
        InputValidator.lerInteiro('\n🎯 Digite o código do item a remover: ');

    if (carrinho.removerItem(codigo)) {
      print('\n✅ Item removido do carrinho!');
    } else {
      print('\n❌ Item não encontrado no carrinho!');
    }
    InputValidator.aguardarEnter();
  }

  /// Finaliza o carrinho de compras
  static bool _finalizarCarrinho(Cliente cliente, Carrinho carrinho) {
    if (carrinho.isEmpty) {
      print('\n❌ Seu carrinho está vazio! Adicione itens antes de finalizar.');
      InputValidator.aguardarEnter();
      return false;
    }

    InputValidator.limparTela();
    InputValidator.exibirTitulo('FINALIZAÇÃO DO PEDIDO', '✅');

    // Exibe resumo do carrinho
    print('\n${carrinho}');

    // Solicita forma de pagamento
    final formaPagamento = _selecionarFormaPagamento();

    // Exibe resumo final
    InputValidator.limparTela();
    print(carrinho.getResumoFinalizacao(formaPagamento));

    if (InputValidator.confirmarAcao(
        '\n💳 Confirma a finalização do pedido?')) {
      // Registra a venda
      GerenciadorVendas.registrarVenda(
        cliente: cliente,
        carrinho: carrinho,
        formaPagamento: formaPagamento,
      );

      // Gera e exibe recibo
      final recibo = GeradorRecibo.gerarRecibo(
        cliente: cliente,
        carrinho: carrinho,
        formaPagamento: formaPagamento,
      );

      InputValidator.limparTela();
      print(recibo);

      print('🎉 Pedido finalizado com sucesso!');
      print('📧 Recibo gerado e venda registrada no sistema.');

      InputValidator.aguardarEnter();
      return true;
    }

    return false;
  }

  /// Permite selecionar forma de pagamento
  static FormaPagamento _selecionarFormaPagamento() {
    print('\n💳 FORMAS DE PAGAMENTO DISPONÍVEIS:');
    InputValidator.exibirSeparador('-', 35);

    final formas = FormaPagamento.values;
    for (int i = 0; i < formas.length; i++) {
      final forma = formas[i];
      final desconto = forma.desconto > 0
          ? ' (${forma.getDescontoFormatado()} desconto)'
          : '';
      print('${i + 1}. ${forma.nome}$desconto');
    }

    final opcao = InputValidator.lerInteiro(
      '\n🎯 Escolha a forma de pagamento: ',
      min: 1,
      max: formas.length,
    );

    return formas[opcao - 1];
  }

  /// Acessa área restrita para funcionários
  static void _acessarAreaRestrita() {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('ÁREA RESTRITA - FUNCIONÁRIOS', '🔒');

    print('\n🔐 Esta área é exclusiva para funcionários da Cuidapet.');
    final senha = InputValidator.lerString('🔑 Digite a senha: ');

    if (senha != senhaRestrita) {
      print('\n❌ Senha incorreta! Acesso negado.');
      InputValidator.aguardarEnter();
      return;
    }

    print('\n✅ Acesso autorizado! Bem-vindo, funcionário.');
    _menuFuncionario();
  }

  /// Menu para funcionários
  static void _menuFuncionario() {
    while (true) {
      InputValidator.limparTela();
      print('\n');
      InputValidator.exibirSeparador('=', 35);
      print('     🏢 MENU FUNCIONÁRIO');
      InputValidator.exibirSeparador('=', 35);
      print('1. 💰 Registrar venda manual');
      print('2. 📊 Ver estatísticas do dia');
      print('3. 🔍 Buscar histórico de cliente');
      print('0. 🚪 Voltar ao menu principal');
      InputValidator.exibirSeparador('=', 35);

      final opcao =
          InputValidator.lerInteiro('\n🎯 Escolha uma opção: ', min: 0, max: 3);

      switch (opcao) {
        case 1:
          _registrarVendaManual();
          break;
        case 2:
          _exibirEstatisticas();
          break;
        case 3:
          _buscarHistoricoCliente();
          break;
        case 0:
          InputValidator.limparTela();
          return;
      }
    }
  }

  /// Registra venda manual (área restrita)
  static void _registrarVendaManual() {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('REGISTRO MANUAL DE VENDA', '💰');

    final nomeCliente = InputValidator.lerString('\n👤 Nome do cliente: ');
    final valor =
        InputValidator.lerDouble('💵 Valor da compra: R\$ ', min: 0.01);

    // Seleciona forma de pagamento
    print('\n💳 Forma de pagamento:');
    final formas = FormaPagamento.values;
    for (int i = 0; i < formas.length; i++) {
      print('${i + 1}. ${formas[i].nome}');
    }

    final opcao = InputValidator.lerInteiro(
      '\n🎯 Escolha a forma de pagamento: ',
      min: 1,
      max: formas.length,
    );
    final formaPagamento = formas[opcao - 1];

    // Confirma o registro
    print('\n📋 RESUMO DA VENDA:');
    print('Cliente: $nomeCliente');
    print('Valor: R\$ ${valor.toStringAsFixed(2)}');
    print('Pagamento: ${formaPagamento.nome}');

    if (InputValidator.confirmarAcao('\n✅ Confirma o registro desta venda?')) {
      GerenciadorVendas.registrarVendaRestrita(
        nomeCliente: nomeCliente,
        valor: valor,
        formaPagamento: formaPagamento,
      );

      // Gera recibo
      final recibo = GeradorRecibo.gerarReciboRestrito(
        nomeCliente: nomeCliente,
        valor: valor,
        formaPagamento: formaPagamento,
        numeroAtendimento: GerenciadorVendas.totalClientesAtendidos,
      );

      InputValidator.limparTela();
      print(recibo);
      print('✅ Venda registrada com sucesso!');
    } else {
      print('\n❌ Registro cancelado.');
    }

    InputValidator.aguardarEnter();
  }

  /// Exibe estatísticas do dia
  static void _exibirEstatisticas() {
    InputValidator.limparTela();
    print(GerenciadorVendas.gerarRelatorioFinal());
    InputValidator.aguardarEnter();
  }

  /// Busca histórico de cliente específico
  static void _buscarHistoricoCliente() {
    InputValidator.limparTela();
    InputValidator.exibirTitulo('BUSCAR HISTÓRICO DE CLIENTE', '🔍');

    final nomeCliente = InputValidator.lerString('\n👤 Nome do cliente: ');
    final historico = GerenciadorVendas.obterHistoricoCliente(nomeCliente);

    if (historico.isEmpty) {
      print('\n❌ Nenhum atendimento encontrado para "$nomeCliente".');
    } else {
      print('\n📋 HISTÓRICO ENCONTRADO:');
      InputValidator.exibirSeparador('-', 40);

      for (int i = 0; i < historico.length; i++) {
        print('${historico[i]}');
        if (i < historico.length - 1) {
          print('');
          InputValidator.exibirSeparador('-', 20);
          print('');
        }
      }
    }

    InputValidator.aguardarEnter();
  }
}

/// Função principal do programa
void main() {
  try {
    SistemaCuidapet.executar();
  } catch (e) {
    print('\n❌ Erro inesperado no sistema: $e');
    print('💡 Reinicie o programa e tente novamente.');
  }
}
