// ignore_for_file: prefer_const_constructors

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
  final List<ExpenseItem> _items = [];

  double get _totalValue {
    return _items.fold(0.0, (sum, item) => sum + double.parse(item.value));
  }

  int _nextId = 1;

  void _showAddExpenseModal(BuildContext context) {
    // Create controllers for the text fields
    final TextEditingController nameController = TextEditingController();
    final TextEditingController valueController = TextEditingController();

    // Create a global key for the form state
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Attach the form key to the Form widget
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Expense Name',
                    labelStyle: TextStyle(
                        color: Colors.white), // Set label color to white
                  ),
                  style: TextStyle(
                      color: Colors.white), // Set input text color to white
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an expense name'; // Validation message
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0), // Add margin between TextFields
                TextFormField(
                  controller: valueController,
                  decoration: InputDecoration(
                    labelText: 'Expense Value',
                    labelStyle: TextStyle(
                        color: Colors.white), // Set label color to white
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.white), // Set input text color to white
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an expense value'; // Validation message
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number'; // Validation message
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height:
                        16.0), // Add margin between TextField and ElevatedButton
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _items.add(ExpenseItem(
                            id: _nextId++,
                            name: nameController.text,
                            value: valueController.text));
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(36, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16), // Adjust the radius for rounded corners
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
          ),
        );
      },
    );
  }

  void _editExpenseItem(int index) {
    // Create controllers for the text fields with initial values
    final TextEditingController nameController =
        TextEditingController(text: _items[index].name);
    final TextEditingController valueController =
        TextEditingController(text: _items[index].value);

    // Create a global key for the form state
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Attach the form key to the Form widget
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Expense Name',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an expense name'; // Validation message
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: valueController,
                  decoration: InputDecoration(
                    labelText: 'Expense Value',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an expense value'; // Validation message
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number'; // Validation message
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _items[index] = ExpenseItem(
                          id: _items[index].id,
                          name: nameController.text,
                          value: valueController.text,
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(36, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteExpenseItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
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
                    '#${_items[index].id.toString()}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    _items[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    _items[index].value,
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => _editExpenseItem(index),
                          icon: Icon(Icons.edit, color: Colors.white)),
                      IconButton(
                          onPressed: () => _deleteExpenseItem(index),
                          icon: Icon(Icons.delete, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseModal(context),
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

class ExpenseItem {
  final int id;
  final String name;
  final String value;

  ExpenseItem({required this.id, required this.name, required this.value});
}
