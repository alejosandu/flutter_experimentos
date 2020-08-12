import 'package:experiments/states/pseudo_bloc_state.dart';
import 'package:flutter/material.dart';

class PseudoBlocPage extends StatefulWidget {
  PseudoBlocPage({Key key}) : super(key: key);

  @override
  Logic createState() => Logic();
}

class PseudoBlocPageState extends StatelessWidget {
  final Logic state;

  PseudoBlocPageState(this.state);

  @override
  Widget build(BuildContext context) {
    print("build PseudoBlocPageState");
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(child: Text("Pseudo Bloc")),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("Se ha presionado el botón ${state.cont} veces"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: state.aumentar,
      ),
    );
  }
}
