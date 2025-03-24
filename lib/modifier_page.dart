import 'package:calcula_preco/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class modifier extends StatefulWidget {
  @override
  State<modifier> createState() => _modifierState();
}

class _modifierState extends State<modifier> {
  final TextEditingController price_controller = TextEditingController();
  final TextEditingController modifier_controller = TextEditingController();
  String price_str = '';
  String modifier_str = '';
  double result = 0;
  String formatted_result = '0,00';
  final dropdown_select = ValueNotifier('');
  final dropdown_options = [
    'Acrescentar em Real',
    'Acrescentar em Percentual',
    'Desconto em Real',
    'Desconto em Percentual',
  ];

  void clear_all() {
    price_controller.clear();
    modifier_controller.clear();
    setState(() {
      price_str = '';
      modifier_str = '';
      result = 0;
      formatted_result = '0,00';
      dropdown_select.value = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Modificador',
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
                'Valor do serviço ou produto: $price_str reais\nValor ou Percentual: $modifier_str reais\nResultado: $result reais',
              );
            },
            icon: Icon(Icons.share),
          ),
          IconButton(onPressed: clear_all, icon: Icon(Icons.delete)),
          SizedBox(width: 10),
        ],
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
      ),
      drawer: sidebar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: dropdown_select,
          builder: (BuildContext context, String value, Widget? child) {
            formatted_result = result.toStringAsFixed(2).replaceAll('.', ',');
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 20,
              children: [
                TextField(
                  onChanged: (text) {
                    price_str = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Valor de serviço ou produto',
                    border: OutlineInputBorder(),
                    hintText: 'R\$99,99',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      DropdownButton(
                        hint: Row(
                          children: [
                            Text('Selecione uma Operação'),
                            SizedBox(width: 180),
                          ],
                        ),
                        value: (value.isEmpty) ? null : value,
                        onChanged:
                            (option) =>
                                dropdown_select.value = option.toString(),
                        items:
                            dropdown_options
                                .map(
                                  (option) => DropdownMenuItem(
                                    value: option,
                                    child: Text(option),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    modifier_str = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Modificador',
                    border: OutlineInputBorder(),
                    hintText: 'R\$40,00',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(3),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10, height: 50),
                      Text('R\$$formatted_result'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 500,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        double price = double.parse(price_str);
                        double modifier = double.parse(modifier_str);
                        if (value == 'Acrescentar em Real') {
                          result = price + modifier;
                        }
                        if (value == 'Acrescentar em Percentual') {
                          result = price + price * (modifier / 100);
                        }
                        if (value == 'Desconto em Real') {
                          result = price - modifier;
                        }
                        if (value == 'Desconto em Percentual') {
                          result = price - price * (modifier / 100);
                        }
                      });
                    },
                    child: Text('Calcular Total'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
