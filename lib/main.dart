import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Cronograma());
}

class Cronograma extends StatelessWidget {
  const Cronograma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API CRONOGRAMAS',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromARGB(150, 0, 0, 0),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descricaoUnidade = TextEditingController();
  final TextEditingController _cargaHorariaUnidade = TextEditingController();
  final TextEditingController _ordem = TextEditingController();
  final TextEditingController _fkCurso = TextEditingController();
  final TextEditingController _descricaorecesso = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro da Tabela de Unidade e Recesso"),
        backgroundColor: Color.fromARGB(255, 3, 62, 255),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _descricaoUnidade,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Descrição da unidade:",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15))),
                        prefixIcon: Icon(Icons.abc)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo Obrigatório!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cargaHorariaUnidade,
                    decoration: const InputDecoration(
                        labelText: "Carga Horária da unidade:",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15))),
                        prefixIcon: Icon(Icons.access_alarms)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo Obrigatório!";
                      }
                      final cargaHoraria = int.tryParse(value);
                      if (cargaHoraria != null && cargaHoraria <= 0) {
                        _cargaHorariaUnidade.clear();
                        return "O valor deve ser maior que 0!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  TextFormField(
                    controller: _ordem,
                    decoration: const InputDecoration(
                        labelText: "Ordem da unidade:",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15))),
                        prefixIcon: Icon(Icons.format_list_numbered)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo Obrigatório!";
                      }
                      final ordem = int.tryParse(value);
                      if (ordem != null && ordem <= 0) {
                        _ordem.clear();
                        return "O valor deve ser maior que 0!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  TextFormField(
                    controller: _fkCurso,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Curso da unidade:",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15))),
                        prefixIcon: Icon(Icons.bookmark_add_outlined)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo Obrigatório!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descricaorecesso,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Informe o nome do feriado:",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(15, 15))),
                      prefixIcon: Icon(Icons.airplanemode_active),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Campo Obrigatório!";
                      }
                      return null;
                    },
                  ),
                  BasicDateField(),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("Unidade cadastrada com sucesso!");
                        Fluttertoast.showToast(
                          msg: "Unidade cadastrada com sucesso!",
                          gravity: ToastGravity.TOP_RIGHT,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
        },
        decoration: const InputDecoration(
          labelText: "Informe a data do feriado:",
          prefixIcon: Icon(Icons.calendar_month),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
        ),
      ),
    ]);
  }
}
