// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../../app_colors.dart';

class RegisterAdminScreen extends StatefulWidget {
  @override
  _RegisterAdminScreenState createState() => _RegisterAdminScreenState();
}

class _RegisterAdminScreenState extends State<RegisterAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  String profession = '';
  bool _loading = false;

  final AuthService _authService = AuthService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null && arg is String) {
      profession = arg;
    }
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Champ obligatoire';
    if (v.length < 8) return 'Minimum 8 caractères';
    final upper = RegExp(r'[A-Z]');
    final lower = RegExp(r'[a-z]');
    final digit = RegExp(r'\d');
    final special = RegExp(r'[!@#\$%\^&\*(),.?":{}|<>]');
    if (!upper.hasMatch(v) ||
        !lower.hasMatch(v) ||
        !digit.hasMatch(v) ||
        !special.hasMatch(v)) {
      return 'Maj, min, chiffre, caractère spécial requis';
    }
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.isEmpty) return 'Champ obligatoire';
    final pattern = RegExp(r'^\+225\d{10,12}$');
    if (!pattern.hasMatch(v)) {
      return 'Format: +2250102030405 (10-12 chiffres)';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!mounted) return;
    setState(() => _loading = true);

    try {
      final user = await _authService.registerAdmin(
        fullName: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
        phone: _phoneCtrl.text.trim(),
        profession: profession,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text('Inscription réussie! Redirection...'),
            ],
          ),
          backgroundColor: Colors.black87,
          duration: Duration(seconds: 3),
        ));

        await Future.delayed(Duration(seconds: 2));

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/config-entreprise');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors de l\'inscription'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur: $e'),
        backgroundColor: Colors.orange,
      ));
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_add, color: Colors.white),
            SizedBox(width: 10),
            Text('Inscription Administrateur'),
          ],
        ),
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Métier
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.work, color: AppColors.primaryOrange),
                            SizedBox(width: 10),
                            Text(
                              'Métier: $profession',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Nom complet
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Nom complet',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(Icons.person_outline,
                            color: AppColors.primaryOrange),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Champ obligatoire' : null,
                    ),
                    SizedBox(height: 20),

                    // Email
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: AppColors.primaryOrange),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Champ obligatoire';
                        if (!v.contains('@')) return 'Email invalide';
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),

                    // Mot de passe
                    TextFormField(
                      controller: _passwordCtrl,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(Icons.lock_outline,
                            color: AppColors.primaryOrange),
                        helperText: '8 caractères, maj, min, chiffre, spécial',
                      ),
                      obscureText: true,
                      validator: _validatePassword,
                    ),
                    SizedBox(height: 20),

                    // Téléphone
                    TextFormField(
                      controller: _phoneCtrl,
                      decoration: InputDecoration(
                        labelText: 'Numéro de téléphone',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(Icons.phone_iphone,
                            color: AppColors.primaryOrange),
                        helperText: 'Format: +2250102030405',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    SizedBox(height: 30),

                    // Bouton d'inscription
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white),
                                  ),
                                  SizedBox(width: 15),
                                  Text('Inscription...',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text('S\'inscrire',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
