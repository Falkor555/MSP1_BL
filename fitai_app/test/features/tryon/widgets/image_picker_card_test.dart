import 'package:fitai_app/features/tryon/presentation/widgets/image_picker_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ImagePickerCard affiche le placeholder par défaut', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImagePickerCard(title: 'Test', imageFile: null, onImageSelected: (_) {}),
      ),
    ));

    expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
    expect(find.text('Appuyez pour sélectionner'), findsOneWidget);
  });
}