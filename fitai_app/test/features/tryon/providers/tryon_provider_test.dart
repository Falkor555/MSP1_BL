import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitai_app/features/tryon/presentation/providers/tryon_provider.dart';

void main() {
  test('État initial du TryOnNotifier est vide', () {
    final container = ProviderContainer();
    final state = container.read(tryOnProvider).value;
    
    expect(state?.personImage, isNull);
    expect(state?.garmentImage, isNull);
    expect(state?.description, isEmpty);
  });
}