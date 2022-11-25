import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arduino ESP8266',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();
  bool lampusatu = false;
  bool lampudua = false;
  final urlController = TextEditingController(text: '192.168.4.1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arduino ESP8266"),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 24.0,
          left: 24.0,
          right: 24.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'IP Arduino',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 24.0),
              child: Row(
                children: [
                  const Text('Lampu 1'),
                  Switch(
                    value: lampusatu,
                    onChanged: (value) {
                      setState(() {
                        lampusatu = value;
                      });
                      if (value) {
                        lampuSatuOn(context);
                      } else {
                        lampuSatuOff(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 12.0),
              child: Row(
                children: [
                  const Text('Lampu 2'),
                  Switch(
                    value: lampudua,
                    onChanged: (value) {
                      setState(() {
                        lampudua = value;
                      });
                      if (value) {
                        lampuDuaOn(context);
                      } else {
                        lampuDuaOff(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void lampuSatuOn(context) async {
    try {
      await dio.get(
        'http://${urlController.text}/lampusatuon',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lampu satu hidup.'),
        ),
      );
    } on DioError catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Arduino tidak ditemukan.'),
        ),
      );
    }
  }

  void lampuSatuOff(context) async {
    try {
      await dio.get(
        'http://${urlController.text}/lampusatuoff',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lampu satu mati.'),
        ),
      );
    } on DioError catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Arduino tidak ditemukan.'),
        ),
      );
    }
  }

  void lampuDuaOn(context) async {
    try {
      await dio.get(
        'http://${urlController.text}/lampuduaon',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lampu dua hidup.'),
        ),
      );
    } on DioError catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Arduino tidak ditemukan.'),
        ),
      );
    }
  }

  void lampuDuaOff(context) async {
    try {
      await dio.get(
        'http://${urlController.text}/lampuduaoff',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lampu dua mati.'),
        ),
      );
    } on DioError catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Arduino tidak ditemukan.'),
        ),
      );
    }
  }
}
