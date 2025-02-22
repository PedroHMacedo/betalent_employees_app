import 'package:intl/intl.dart';

class FormatterService {
  static String formatDate(String isoDate) {
    try {
      DateTime parsedDate = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'Data inválida';
    }
  }

  static String formatPhoneNumber(String phone) {
    if (!RegExp(r'^\d+$').hasMatch(phone)) return 'Número inválido';
    if (phone.length < 10 || phone.length > 13) return 'Número inválido';

    String countryCode =
        phone.length > 11 ? '+${phone.substring(0, 2)} ' : '+55 ';
    String ddd = '(${phone.substring(phone.length - 11, phone.length - 9)}) ';
    String firstPart = phone.substring(phone.length - 9, phone.length - 4);
    String secondPart = phone.substring(phone.length - 4);

    return '$countryCode$ddd$firstPart-$secondPart';
  }
}
