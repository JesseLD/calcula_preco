import 'package:calcula_preco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class calculate extends StatefulWidget {
  @override
  State<calculate> createState() => _calculateState();
}

class _calculateState extends State<calculate> {
  final TextEditingController cost_controller = TextEditingController();
  final TextEditingController desired_gain_controller = TextEditingController();
  final TextEditingController variable_controller = TextEditingController();
  final TextEditingController ICMScontroller = TextEditingController();
  final TextEditingController tax_controller = TextEditingController();
  String cost_str = '';
  String desired_gain_str = '';
  String variable_str = '';
  String ICMS_str = '';
  String tax_str = '';
  double markup = 0;
  String formatted_markup = '0,0';
  double markup_percent = 0;
  String formatted_markup_percent = '0,0';
  double markup_real = 0;
  String formatted_markup_real = '0,0';
  double sell_price = 0;
  String formatted_sell_price = '0,00';
  double gain_margin = 0;
  String formatted_gain_margin = '0,00';
  double gain_real = 0;
  String formatted_gain_real = '0,00';
  double difference = 0;
  double total_cost = 0;
  double ICMS_real = 0;
  double tax_real = 0;
  double desired_gain_real = 0;
  double gain_margin_real = 0;

  void clear_all() {
    cost_controller.clear();
    desired_gain_controller.clear();
    variable_controller.clear();
    ICMScontroller.clear();
    tax_controller.clear();
    setState(() {
      cost_str = '';
      desired_gain_str = '';
      variable_str = '';
      ICMS_str = '';
      tax_str = '';
      markup = 0;
      formatted_markup = '0,0';
      markup_percent = 0;
      formatted_markup_percent = '0,0';
      sell_price = 0;
      formatted_sell_price = '0,00';
      gain_margin = 0;
      formatted_gain_margin = '0,00';
      gain_real = 0;
      formatted_gain_real = '0,00';
      difference = 0;
      total_cost = 0;
      desired_gain_real = 0;
      gain_margin_real = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    formatted_markup = markup.toStringAsFixed(1).replaceAll('.', ',');
    formatted_markup_percent = markup_percent
        .toStringAsFixed(2)
        .replaceAll('.', ',');
    formatted_sell_price = sell_price.toStringAsFixed(2).replaceAll('.', ',');
    formatted_gain_real = gain_real.toStringAsFixed(2).replaceAll('.', ',');
    formatted_gain_margin = gain_margin.toStringAsFixed(2).replaceAll('.', ',');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Calcular Preço',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (BuildContext context) => AlertDialog(
                      content: Text(
                        'O Calcula Preço simplifica a precificação e a análise de lucros, diferenciando a porcentagem e a margem de lucro.\nCalcule preços de venda, analise lucros e compartilhe resultados.\nConsidere custos, impostos, margens e muito mais.\n\nDesenvolvimento Reale Tech\n(75)2102-9200\nwww.realetech.com.br',
                        textAlign: TextAlign.center,
                      ),
                    ),
              );
            },
            icon: Icon(Icons.info),
          ),
          IconButton(
            onPressed: () {
              if (cost_str.isNotEmpty) {
                Share.share(
                  'Markup: $formatted_markup / $formatted_markup_percent%\nPreço de venda: R\$$formatted_sell_price\nMargem de Lucro: $formatted_gain_margin%\nLucro Líquido: R\$$formatted_gain_real',
                );
              }
            },
            icon: Icon(Icons.share),
          ),
          IconButton(onPressed: clear_all, icon: Icon(Icons.delete)),
        ],
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
      ),
      drawer: sidebar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 20,
            children: [
              TextField(
                controller: cost_controller,
                onChanged: (text) {
                  cost_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Preço de Custo',
                  border: OutlineInputBorder(),
                  hintText: 'R\$99,99',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: desired_gain_controller,
                onChanged: (text) {
                  desired_gain_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Porcentagem de Lucro Desejada',
                  border: OutlineInputBorder(),
                  hintText: '40%',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: variable_controller,
                onChanged: (text) {
                  variable_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Custos Variáveis',
                  border: OutlineInputBorder(),
                  hintText: 'R\$29,99',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: ICMScontroller,
                onChanged: (text) {
                  ICMS_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Diferença Tributária de ICMS',
                  border: OutlineInputBorder(),
                  hintText: '9%',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tax_controller,
                onChanged: (text) {
                  tax_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Imposto sobre Venda (%)',
                  border: OutlineInputBorder(),
                  hintText: '1%',
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10, height: 50),
                        Text(
                          style: TextStyle(fontSize: 15),
                          'Markup: $formatted_markup / $formatted_markup_percent% / R\$$formatted_gain_real',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (BuildContext context) => AlertDialog(
                              content: Text(
                                'O Markup ajuda a definir o preço de venda cobrindo custos e garantindo lucro.\n\n📌 Fórmula:\nMarkup = 100 / (100 - (Custos Variáveis + ICMS + Imposto sobre Venda + Lucro Desejado))',
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10, height: 50),
                        Text(
                          style: TextStyle(fontSize: 15),
                          'Preço de Venda: R\$$formatted_sell_price',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (BuildContext context) => AlertDialog(
                              content: Text(
                                'O preço de venda é um fator essencial para garantir a sustentabilidade do negócio, cobrindo todos os custos e assegurando a margem de lucro desejada.\n\n📌 Fórmula:\nPreço de Venda = (Custos Totais + Lucro Desejado)',
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10, height: 50),
                        Text(
                          style: TextStyle(fontSize: 15),
                          'Margem de Lucro: $formatted_gain_margin%',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (BuildContext context) => AlertDialog(
                              content: Text(
                                'A margem de lucro é um indicador fundamental para avaliar a rentabilidade de um negócio, demonstrando a porcentagem de lucro obtida sobre as vendas.\n\n📌 Fórmula:\nMargem de Lucro (%) = (Lucro Líquido / Receita Total) × 100\n\nEssa métrica ajuda a entender a eficiência financeira da empresa e a tomar decisões estratégicas para otimizar os ganhos.',
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10, height: 50),
                        Text(
                          style: TextStyle(fontSize: 15),
                          'Lucro Líquido: R\$$formatted_gain_real',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (BuildContext context) => AlertDialog(
                              content: Text(
                                'O lucro líquido é um dos principais indicadores financeiros de um negócio, representando o valor que a empresa realmente ganha após descontar todas as despesas.\n\n📌 Fórmula:\nLucro Líquido = Receita Total - (Custos Fixos + Custos Variáveis + Impostos + Despesas Operacionais)\n\nEsse cálculo é essencial para medir a saúde financeira da empresa e auxiliar na tomada de decisões estratégicas.',
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (cost_str.isNotEmpty && desired_gain_str.isNotEmpty) {
                        double cost = double.parse(cost_str);
                        double desired_gain_percent = double.parse(
                          desired_gain_str,
                        );
                        double variable = double.parse(variable_str);
                        double ICMS_percent = double.parse(ICMS_str);
                        double tax_percent = double.parse(tax_str);
                        ICMS_real = (cost * ICMS_percent) / 100;
                        tax_real = (cost * tax_percent) / 100;
                        desired_gain_real = (cost * desired_gain_percent) / 100;
                        markup_real = (cost * markup_percent) / 100;

                        total_cost = cost + variable + ICMS_real + tax_real;

                        markup =
                            2 + (desired_gain_real - total_cost) / total_cost;
                        markup_percent =
                            -((desired_gain_real - total_cost) / total_cost) *
                            100;

                        sell_price =
                            total_cost +
                            (cost *
                                    -((desired_gain_real - total_cost) /
                                        total_cost) *
                                    100) /
                                100;

                        difference = sell_price - total_cost;
                        gain_margin_real = difference / sell_price;
                        gain_margin = gain_margin_real * 100;
                        gain_real = gain_margin_real * total_cost;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                  ),
                  child: Text('Calcular'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
