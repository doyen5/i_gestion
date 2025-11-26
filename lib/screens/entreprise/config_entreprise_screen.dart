// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../app_colors.dart';

class ConfigEntrepriseScreen extends StatefulWidget {
  const ConfigEntrepriseScreen({super.key});

  @override
  State<ConfigEntrepriseScreen> createState() => _ConfigEntrepriseScreenState();
}

class _ConfigEntrepriseScreenState extends State<ConfigEntrepriseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomEntrepriseCtrl = TextEditingController();
  final TextEditingController _adresseCtrl = TextEditingController();
  final TextEditingController _villeCtrl = TextEditingController();
  final TextEditingController _telephoneCtrl = TextEditingController();
  String _selectedType = 'SARL';

  Future<void> _validerConfiguration() async {
    if (!_formKey.currentState!.validate()) return;

    // Simulation sauvegarde
    await Future.delayed(Duration(seconds: 1));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Entreprise configurée avec succès!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuration Entreprise'),
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // En-tête
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.business, color: AppColors.primaryOrange),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Configurez votre entreprise',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Formulaire
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nomEntrepriseCtrl,
                          decoration: InputDecoration(
                            labelText: 'Nom de l\'entreprise',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.business_outlined,
                                color: AppColors.primaryOrange),
                          ),
                          validator: (v) => v == null || v.isEmpty
                              ? 'Champ obligatoire'
                              : null,
                        ),
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: InputDecoration(
                            labelText: 'Type d\'entreprise',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.type_specimen,
                                color: AppColors.primaryOrange),
                          ),
                          items:
                              ['SARL', 'SA', 'SAS', 'EI', 'Auto-entrepreneur']
                                  .map((type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ))
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value!;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _adresseCtrl,
                          decoration: InputDecoration(
                            labelText: 'Adresse',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.location_on_outlined,
                                color: AppColors.primaryOrange),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _villeCtrl,
                          decoration: InputDecoration(
                            labelText: 'Ville',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.location_city_outlined,
                                color: AppColors.primaryOrange),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _telephoneCtrl,
                          decoration: InputDecoration(
                            labelText: 'Téléphone entreprise',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.phone_outlined,
                                color: AppColors.primaryOrange),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _validerConfiguration,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Valider la configuration',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
