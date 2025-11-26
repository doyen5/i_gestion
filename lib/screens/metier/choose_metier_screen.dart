import 'package:flutter/material.dart';
import '../../app_colors.dart';

class ChooseMetierScreen extends StatelessWidget {
  final List<Map<String, String>> metiers = [
    {'label': 'Restauration', 'key': 'restauration'},
    {'label': 'Pressing', 'key': 'pressing'},
    {'label': 'Salon de coiffure', 'key': 'coiffure'},
    {'label': 'Réparation smartphone', 'key': 'reparation'},
  ];

  ChooseMetierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Choisissez votre métier'),
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: metiers.length,
          itemBuilder: (context, index) {
            final m = metiers[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register-admin',
                    arguments: m['key']);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getMetierIcon(m['key']!),
                      size: 40,
                      color: AppColors.primaryOrange,
                    ),
                    SizedBox(height: 10),
                    Text(
                      m['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getMetierIcon(String metierKey) {
    switch (metierKey) {
      case 'restauration':
        return Icons.restaurant;
      case 'pressing':
        return Icons.local_laundry_service;
      case 'coiffure':
        return Icons.content_cut;
      case 'reparation':
        return Icons.phone_android;
      default:
        return Icons.business;
    }
  }
}
