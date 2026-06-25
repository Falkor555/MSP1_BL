import 'package:flutter/material.dart';

class TryOnScreen extends StatelessWidget {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Plus de Scaffold ici, juste le contenu central
    return const Center(
      child: Text('Écran : Nouvel essayage', style: TextStyle(fontSize: 18)),
    );
  }
}