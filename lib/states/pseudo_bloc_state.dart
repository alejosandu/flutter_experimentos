import 'package:experiments/pages/pseudo_bloc_page.dart';
import 'package:flutter/material.dart';

class Logic extends State<PseudoBlocPage> {
  int _cont = 0;
  int get cont => _cont;

  aumentar() {
    print("aumenta $_cont");
    setState(() => _cont++);
  }

  @override
  Widget build(BuildContext context) {
    return PseudoBlocPageState(this);
  }
}
