import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: '0,00'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.greenAccent[700],
                  fontSize: 80.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(height: 20.0),
              const Text(
                'that could be yours',
                style: TextStyle(
                  color: Color.fromARGB(200, 255, 255, 255),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 250.0,
      ),
      body: Container(
        color: Color.fromARGB(255, 26, 26, 26),
        child: const Center(
          child: Column(
            children: [
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Color.fromARGB(36, 255, 255, 255),
        child: const Text(
          '💸',
          style: TextStyle(
            fontSize: 30.0,
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}