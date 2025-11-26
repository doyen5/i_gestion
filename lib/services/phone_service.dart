// lib/services/phone_service.dart
class PhoneService {
  // Nettoie et formate le numéro de téléphone
  static String? cleanPhoneNumber(String phone) {
    if (phone.isEmpty) return null;

    // Supprime tous les caractères non numériques sauf le +
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // Gestion des différents formats
    if (cleaned.startsWith('+225')) {
      // Format: +2250102030405
      cleaned = cleaned.substring(1); // Supprime le + pour avoir 2250102030405
    } else if (cleaned.startsWith('225')) {
      // Format: 2250102030405
      // Déjà bon
    } else if (cleaned.startsWith('00225')) {
      // Format: 002250102030405
      cleaned = cleaned.substring(2); // Supprime 00 pour avoir 2250102030405
    } else if (cleaned.length == 8 || cleaned.length == 10) {
      // Format local: 0102030405 ou 01234567
      cleaned = '225$cleaned'; // Ajoute l'indicatif
    }

    // Validation finale
    if (cleaned.length == 12 && cleaned.startsWith('225')) {
      return cleaned; // Format final: 2250102030405
    }

    return null; // Numéro invalide
  }

  // Formate pour l'affichage
  static String formatForDisplay(String phone) {
    String cleaned = cleanPhoneNumber(phone) ?? phone;

    if (cleaned.length == 12 && cleaned.startsWith('225')) {
      // Format: +225 01 02 03 04 05
      String number = cleaned.substring(3);
      return '+225 ${number.substring(0, 2)} ${number.substring(2, 4)} ${number.substring(4, 6)} ${number.substring(6, 8)}';
    }

    return phone;
  }

  // Vérifie si le numéro est valide
  static bool isValidPhoneNumber(String phone) {
    return cleanPhoneNumber(phone) != null;
  }

  // Extrait uniquement les chiffres du numéro
  static String getDigitsOnly(String phone) {
    return phone.replaceAll(RegExp(r'[^\d]'), '');
  }
}
