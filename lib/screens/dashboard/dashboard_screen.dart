// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../../services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthService _authService = AuthService();
  int _currentIndex = 0;

  // Statistiques simulées
  final Map<String, dynamic> _stats = {
    'ventes': '125,400 Fcfa',
    'clients': '89',
    'produits': '45',
    'revenu': '2,450,000 Fcfa',
  };

  // Dernières activités
  final List<Map<String, String>> _activites = [
    {
      'titre': 'Vente #00125',
      'sousTitre': 'Client: Jean Dupont',
      'montant': '+25,000 F'
    },
    {'titre': 'Nouveau client', 'sousTitre': 'Marie Konan', 'montant': ''},
    {
      'titre': 'Achat stock',
      'sousTitre': 'Fournisseur: ABC Ltd',
      'montant': '-150,000 F'
    },
    {
      'titre': 'Vente #00126',
      'sousTitre': 'Client: Sara Traoré',
      'montant': '+18,500 F'
    },
  ];

  Future<void> _deconnexion() async {
    await _authService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Tableau de Bord'),
        backgroundColor: AppColors.primaryOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _deconnexion,
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête
            Text(
              'Aperçu général',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Voici un résumé de votre activité',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),

            // Cartes de statistiques
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard('Ventes du jour', _stats['ventes']!,
                    Icons.shopping_cart, Colors.blue),
                _buildStatCard(
                    'Clients', _stats['clients']!, Icons.people, Colors.green),
                _buildStatCard('Produits', _stats['produits']!,
                    Icons.inventory_2, Colors.orange),
                _buildStatCard('Revenu mensuel', _stats['revenu']!,
                    Icons.attach_money, Colors.purple),
              ],
            ),
            SizedBox(height: 30),

            // Dernières activités
            Text(
              'Dernières activités',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: _activites
                      .map((activite) => _buildActiviteItem(activite))
                      .toList(),
                ),
              ),
            ),

            // Actions rapides
            SizedBox(height: 30),
            Text(
              'Actions rapides',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildActionCard(
                    'Nouvelle vente', Icons.point_of_sale, Colors.green),
                _buildActionCard('Gérer stock', Icons.inventory, Colors.blue),
                _buildActionCard('Clients', Icons.people_alt, Colors.orange),
                _buildActionCard('Rapports', Icons.analytics, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String titre, String valeur, IconData icone, Color couleur) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 30, color: couleur),
            SizedBox(height: 10),
            Text(
              valeur,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              titre,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiviteItem(Map<String, String> activite) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activite['titre']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  activite['sousTitre']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (activite['montant']!.isNotEmpty)
            Text(
              activite['montant']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: activite['montant']!.startsWith('+')
                    ? Colors.green
                    : Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String titre, IconData icone, Color couleur) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Action à implémenter
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 30, color: couleur),
              SizedBox(height: 8),
              Text(
                titre,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
