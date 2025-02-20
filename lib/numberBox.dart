import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
  final child;
  bool revealed;
  final function;

  MyNumberBox(this.child, this.revealed, this.function);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
          child: Container(
            color: revealed ? Colors.grey[300] : Colors.grey[400],
            child: Center(child: Text(
              revealed ? child.toString() : ""),
              ),
          ),
        ),
    );
  }
}