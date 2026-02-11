# 🐾 Sistema de Auto Atendimento Cuidapet
Sistema completo de autoatendimento desenvolvido em Dart para a loja Cuidapet, oferecendo uma experiência interativa e personalizada para clientes e funcionalidades administrativas para funcionários.

## 📋 Descrição do Sistema
O Sistema de Auto Atendimento Cuidapet foi desenvolvido para otimizar a experiência do cliente no ponto de venda e apoiar o crescimento da empresa. O sistema permite:

### ✨ Atendimento personalizado: com saudação baseada no horário.

### 🛒 Carrinho de compras: com limite de 3 itens.

### 💳 Múltiplas formas de pagamento: com descontos automáticos.

### 🔒 Área restrita: para funcionários.

### 📊 Relatórios e estatísticas: de vendas.

### 🧾 Geração automática: de recibos.

## 🚀 Funcionalidades Principais
Para Clientes:
Mensagem de Boas-vindas Personalizada: Saudação baseada no horário do dia.

Visualização de Produtos: 4 produtos em promoção com códigos e preços.

Solicitação de Serviços: 3 serviços disponíveis com informações detalhadas.

Carrinho de Compras: Adicionar/remover até 3 itens com validação.

Finalização com Desconto: Cálculo automático de descontos por forma de pagamento.

Recibo Detalhado: Geração automática de comprovante formatado.

Para Funcionários (Área Restrita):
Autenticação: Acesso protegido por senha (cuidapetrestrito).

Registro Manual de Vendas: Inserção direta de vendas no sistema.

Relatórios em Tempo Real: Estatísticas do dia e resumo financeiro.

Busca de Histórico: Consulta de atendimentos por cliente.

🛠️ Tecnologias Utilizadas
Linguagem: Dart 2.19+

Paradigma: Orientação a Objetos (OOP).

Interface: Console interativo.

Arquitetura: Modular com separação de responsabilides

---
```
## 📁 Estrutura do Projeto

CuidadoPet/
├── bin/
│   └── main.dart                    # Arquivo principal do sistema
├── lib/
│   ├── models/                      # Modelos de dados
│   │   ├── item.dart               # Classe abstrata base
│   │   ├── produto.dart            # Model de produtos
│   │   ├── servico.dart            # Model de serviços
│   │   ├── cliente.dart            # Model de clientes
│   │   ├── carrinho.dart           # Model do carrinho e formas de pagamento
│   │   └── historico_atendimento.dart # Model do histórico
│   ├── services/                    # Camada de serviços
│   │   └── gerenciador_vendas.dart # Gerenciamento de vendas e relatórios
│   └── utils/                       # Utilitários
│       ├── input_validator.dart    # Validação de entradas
│       └── gerador_recibo.dart     # Geração de recibos
├── pubspec.yaml                     # Configuração do projeto
└── README.md                        # Este arquivo
```
## 💰 Formas de Pagamento e Descontos
Forma de Pagamento,Desconto
💵 Dinheiro,10%
💳 PIX,8%
💳 Cartão Débito,5%
💳 Cartão Crédito,0%

## 📦 Produtos em Promoção
Código,Produto,Preço,Categoria
101,Ração Premium Cães 15kg,"R$ 89,90",Alimentação
102,Brinquedo Corda Colorida,"R$ 15,50",Brinquedos
103,Shampoo Antipulgas 500ml,"R$ 24,90",Higiene
104,Casa de Madeira Média,"R$ 199,00",Acessórios

## 🔧 Requisitos para Execução
- Dart SDK: Versão 2.19.0 ou superior.
- Sistema Operacional: Windows, macOS ou Linux.

## 📥 Instalação
git clone https://github.com/samueljunqueiraa/CuidadoPet.git
cd CuidadoPet

## ▶️ Como Executar
```
dart run bin/main.dart
```

## 🏗️ Arquitetura e Padrões
O projeto utiliza Design Patterns (Singleton, Strategy, Factory) e princípios SOLID, demonstrando uma base sólida de engenharia de software aplicável tanto em Dart quanto em Java.

## 🐾 Cuidapet - Cuidando do seu pet com amor e tecnologia! ❤️

Deseja que eu ajude a configurar o arquivo .gitignore para garantir que a pasta build/ ou .dart_tool/ não suba junto com este README?
