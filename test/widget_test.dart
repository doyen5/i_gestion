// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:i_gestion/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester
        .pumpWidget(IGestionApp()); // CORRECTION: MyApp() → IGestionApp()

    // Comme notre app n'a pas de compteur, on teste la présence d'éléments de base
    // Vérifie que l'écran de splash est présent
    expect(find.text('Bienvenue. Chargement en cours...'), findsOneWidget);
  });

  testWidgets('Navigation vers sélection métier', (WidgetTester tester) async {
    await tester.pumpWidget(IGestionApp());

    // Attendre que l'animation se termine
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Vérifier qu'on arrive sur l'écran de sélection du métier
    expect(find.text('Choisissez votre métier'), findsOneWidget);
  });
}
