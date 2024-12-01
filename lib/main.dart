import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para converter o JSON

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn = false; 
  String status = 'Desconhecido';

  @override
  void initState() {
    super.initState();
    print('App iniciado');
    fetchStatus();
  }

  Future<void> fetchStatus() async {
    try {
      final response =
          await http.get(Uri.parse('http://50.19.176.239:5000/status'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          status = data.toString(); 
          isOn = data['status'] == true; 
        });

        print(isOn ? 'O dispositivo está Ligado' : 'O dispositivo está Desligado');
      } else {
        setState(() {
          status = 'Erro na requisição';
        });
      }
    } catch (e) {
      setState(() {
        status = 'Falha na conexão';
      });
    }
  }

  Future<void> toggleDevice() async {
  try {
    String statusValue = isOn ? 'desativar' : 'ativar';

    final response = await http.post(
      Uri.parse('http://50.19.176.239:5000/desativar-ativar'),
      headers: {
        'Content-Type': 'application/json',
        'stats': statusValue,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        isOn = !isOn; 
      });

      print(isOn ? 'O dispositivo foi Ligado' : 'O dispositivo foi Desligado');
    } else {
      setState(() {
        status = 'Erro ao alterar o status';
      });
      print('Erro ao alterar o status');
    }
  } catch (e) {
    setState(() {
      status = 'Falha na conexão';
    });
    print('Falha na conexão');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text(
          'Botão com Ícone de Luz',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, 
          ),
        ),
        backgroundColor: Colors.grey[900], 
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                toggleDevice(); 
              },
              icon: Icon(
                isOn
                    ? Icons.lightbulb
                    : Icons.lightbulb_outline, 
                size: 40, 
                color: isOn
                    ? Colors.yellow[700]
                    : Colors.grey[600], 
              ),
              label: Text(
                isOn ? 'Ligado' : 'Desligado', 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.w600, 
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isOn
                    ? Colors.green[700]
                    : Colors.grey[800],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), 
                ),
                shadowColor: Colors.black45, 
                elevation: 6, 
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
