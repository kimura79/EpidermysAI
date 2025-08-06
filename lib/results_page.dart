import 'dart:io';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String imagePath;
  const ResultsPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisi 1 (Placeholder)')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text('Overlay 1', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Image.file(File(imagePath)),
          const SizedBox(height: 10),
          const Text('Score: —', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
