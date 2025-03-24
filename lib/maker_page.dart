import 'package:calcula_preco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class maker extends StatefulWidget {
  @override
  State<maker> createState() => _makerState();
}

class _makerState extends State<maker> {
  final TextEditingController production_cost_controller =
      TextEditingController();
  final TextEditingController transport_controller = TextEditingController();
  final TextEditingController IPIcontroller = TextEditingController();
  final TextEditingController ICMScontroller = TextEditingController();
  final TextEditingController operational_cost_controller =
      TextEditingController();
  final TextEditingController gain_percent_controller = TextEditingController();
  final TextEditingController tax_controller = TextEditingController();
  String production_cost_str = '';
  String transport_str = '';
  String IPI_str = '';
  String ICMS_str = '';
  String operational_cost_str = '';
  double total_cost = 0;
  String formatted_total_cost = '0,00';
  String gain_percent_str = '';
  double total_without_tax = 0;
  String formatted_total_without_tax = '0,00';
  String tax_str = '';
  double total_with_note = 0;
  String formatted_total_with_note = '0,00';

  void clear_all() {
    production_cost_controller.clear();
    transport_controller.clear();
    IPIcontroller.clear();
    ICMScontroller.clear();
    operational_cost_controller.clear();
    gain_percent_controller.clear();
    tax_controller.clear();
    setState(() {
      production_cost_str = '';
      transport_str = '';
      IPI_str = '';
      ICMS_str = '';
      operational_cost_str = '';
      total_cost = 0;
      formatted_total_cost = '0,00';
      gain_percent_str = '';
      total_without_tax = 0;
      formatted_total_without_tax = '0,00';
      tax_str = '';
      total_with_note = 0;
      formatted_total_with_note = '0,00';
    });
  }

  @override
  Widget build(BuildContext context) {
    formatted_total_cost = total_cost.toStringAsFixed(2).replaceAll('.', ',');
    formatted_total_without_tax = total_without_tax
        .toStringAsFixed(2)
        .replaceAll('.', ',');
    formatted_total_with_note = total_with_note
        .toStringAsFixed(2)
        .replaceAll('.', ',');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Formar Preço',
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
              Share.share(
                'Preço de Custo de Produção = $production_cost_str reais\nFrete = $transport_str reais\nIPI = $IPI_str%\nDiferença Tributária de ICMS = $ICMS_str%\nCusto Operacional = $operational_cost_str reais\nTotal de Custo = $total_cost reais\nPercentual de Lucro = $gain_percent_str%\nTotal do valor sem imposto = $total_without_tax reais\nImposto sobre Venda = $tax_str%\nTotal do valor sem imposto = $total_without_tax reais\nTotal do valor com nota = $total_with_note reais.',
              );
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
                controller: production_cost_controller,
                onChanged: (text) {
                  production_cost_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Preço de Custo de Produção',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: transport_controller,
                onChanged: (text) {
                  transport_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Frete',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: IPIcontroller,
                onChanged: (text) {
                  IPI_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'IPI (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: ICMScontroller,
                onChanged: (text) {
                  ICMS_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Diferença Tributária de ICMS (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: operational_cost_controller,
                onChanged: (text) {
                  operational_cost_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Custo Operacional',
                  border: OutlineInputBorder(),
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
                          'Total de Custo: R\$$formatted_total_cost',
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
                                'O total de custo representa a soma de todas as despesas envolvidas na produção ou prestação de um serviço, sendo um fator essencial para a definição do preço de venda e da lucratividade.\n\n📌 Fórmula:\nTotal de Custo = Custos Fixos + Custos Variáveis\n\nEsse cálculo permite uma visão clara dos gastos do negócio, ajudando a otimizar processos e maximizar os lucros.',
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              TextField(
                onChanged: (text) {
                  gain_percent_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Percentual de Lucro (%)',
                  border: OutlineInputBorder(),
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
                          'Total do valor sem imposto: R\$$formatted_total_without_tax',
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
                                'O total com lucro e sem imposto representa o valor da venda considerando a margem de lucro desejada, mas sem a inclusão dos impostos.\n\n📌 Fórmula:\nTotal com Lucro e sem Imposto = (Custo Total × Markup)',
                              ),
                            ),
                      );
                    },
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              TextField(
                onChanged: (text) {
                  tax_str = text;
                },
                decoration: InputDecoration(
                  labelText: 'Imposto sobre Venda (%)',
                  border: OutlineInputBorder(),
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
                          'Total do valor com nota: R\$$formatted_total_with_note',
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
                                'O total do valor com nota representa o preço final de venda já incluindo os impostos, refletindo o valor total que o cliente pagará na compra.\n\n📌 Fórmula:\nTotal do Valor com Nota = Preço de Venda + Impostos',
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
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        total_cost = production_cost;
                      }
                      if (production_cost_str.isEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isEmpty) {
                        double transport = double.parse(transport_str);
                        total_cost = transport;
                      }
                      if (production_cost_str.isEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isNotEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isEmpty) {
                        double IPI = double.parse(IPI_str);
                        total_cost = IPI;
                      }
                      if (production_cost_str.isEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isNotEmpty &&
                          operational_cost_str.isEmpty) {
                        double ICMS = double.parse(ICMS_str);
                        total_cost = ICMS;
                      }
                      if (production_cost_str.isEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isNotEmpty) {
                        double operational_cost = double.parse(
                          operational_cost_str,
                        );
                        total_cost = operational_cost;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double transport = double.parse(transport_str);
                        total_cost = production_cost + transport;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isNotEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double IPI = double.parse(IPI_str);
                        total_cost = production_cost + IPI;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isNotEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double ICMS = double.parse(ICMS_str);
                        total_cost = production_cost + ICMS;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isNotEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double operational_cost = double.parse(
                          operational_cost_str,
                        );
                        total_cost = production_cost + operational_cost;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isNotEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double transport = double.parse(transport_str);
                        double IPI = double.parse(IPI_str);
                        total_cost = production_cost + transport + IPI;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isNotEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double transport = double.parse(transport_str);
                        double ICMS = double.parse(ICMS_str);
                        total_cost = production_cost + transport + ICMS;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isEmpty &&
                          ICMS_str.isEmpty &&
                          operational_cost_str.isNotEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double transport = double.parse(transport_str);
                        double operational_cost = double.parse(
                          operational_cost_str,
                        );
                        total_cost =
                            production_cost + transport + operational_cost;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isNotEmpty &&
                          ICMS_str.isNotEmpty &&
                          operational_cost_str.isEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double transport = double.parse(transport_str);
                        double IPI = double.parse(IPI_str);
                        double ICMS = double.parse(ICMS_str);
                        total_cost = production_cost + transport + IPI + ICMS;
                      }
                      if (production_cost_str.isNotEmpty &&
                          transport_str.isNotEmpty &&
                          IPI_str.isNotEmpty &&
                          ICMS_str.isNotEmpty &&
                          operational_cost_str.isNotEmpty) {
                        double production_cost = double.parse(
                          production_cost_str,
                        );
                        double transport = double.parse(transport_str);
                        double IPI = double.parse(IPI_str);
                        double ICMS = double.parse(ICMS_str);
                        double operational_cost = double.parse(
                          operational_cost_str,
                        );
                        total_cost =
                            production_cost +
                            transport +
                            IPI +
                            ICMS +
                            operational_cost;
                      }
                      if (gain_percent_str.isNotEmpty) {
                        double gain_percent = double.parse(gain_percent_str);
                        total_without_tax =
                            total_cost * (1 + (gain_percent / 100));
                      } else {
                        total_without_tax = total_cost;
                      }
                      if (tax_str.isNotEmpty) {
                        double tax = double.parse(tax_str);
                        total_with_note = total_without_tax * (1 + (tax / 100));
                      } else {
                        total_with_note = total_without_tax;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                  ),
                  child: Text('Calcular Total de Custo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
