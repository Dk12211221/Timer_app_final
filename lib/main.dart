import 'package:flutter/material.dart';
void main(){
  runApp(const MaterialApp(
    home: hello(),
  ),
  );
}

class hello extends StatelessWidget {
  const hello({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Spacer(),
          Text('Hello'),
          Spacer(),
          Text('World'),
          Spacer(),
          Text('Flutter'),
          Spacer(),
        ],
      ),
    );
  }
}