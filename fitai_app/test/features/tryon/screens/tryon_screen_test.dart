import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fitai_app/features/tryon/presentation/screens/tryon_screen.dart';

void main() {
  testWidgets('Bouton Générer est désactivé si pas d\'images', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: Scaffold(body: TryOnScreen()))),
    );
    
    final button = find.byType(ElevatedButton);
    // Vérifie que le bouton n'a pas de callback onPressed quand aucune image n'est choisie
    final ElevatedButton btnWidget = tester.widget(button);
    expect(btnWidget.onPressed, isNull);
  });
}