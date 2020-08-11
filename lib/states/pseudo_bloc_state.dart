import 'package:experiments/pages/pseudo_bloc_page.dart';
import 'package:flutter/material.dart';

class Logic extends State<PseudoBlocPage> {
  int _cont = 0;

  _aumentar() {
    print("aumenta");
    setState(() => _cont++);
  }

  void setState(fn) {
    print("setState Logic");
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class PseudoBlocPageState extends Logic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(child: Text("Pseudo Bloc")),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("Se ha presionado el botón $_cont veces"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _aumentar,
      ),
    );
  }
}
