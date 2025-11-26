import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tableau de Bord')),
      body: Center(
        child: Text('Écran Dashboard - À implémenter'),
      ),
    );
  }
}
