import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<CurrencyItem> _items = [];

  double get _totalValue {
    return _items.fold(0.0, (sum, item) => sum + double.parse(item.value));
  }

  void _showAddCurrencyModal(BuildContext context) {
    String currencyName = '';
    String currencyValue = '';

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Currency Name',
                  labelStyle: TextStyle(color: Colors.white), // Set label color to white
                ),
                style: TextStyle(color: Colors.white), // Set input text color to white
                onChanged: (value) {
                  currencyName = value;
                },
              ),
              SizedBox(height: 16.0), // Add margin between TextFields
              TextField(
                decoration: InputDecoration(
                  labelText: 'Currency Value',
                  labelStyle: TextStyle(color: Colors.white), // Set label color to white
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white), // Set input text color to white
                onChanged: (value) {
                  currencyValue = value;
                },
              ),
              SizedBox(height: 16.0), // Add margin between TextField and ElevatedButton
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _items.add(CurrencyItem(name: currencyName, value: currencyValue));
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(36, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Adjust the radius for rounded corners
                  ),
                  padding: EdgeInsets.all(10),
                ),
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                _totalValue.toStringAsFixed(2),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _items[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    _items[index].value,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCurrencyModal(context),
        backgroundColor: Color.fromARGB(36, 255, 255, 255),
        child: const Text(
          '💸',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CurrencyItem {
  final String name;
  final String value;

  CurrencyItem({required this.name, required this.value});
}