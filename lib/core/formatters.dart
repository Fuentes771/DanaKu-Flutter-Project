import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

final _idr = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
final _idrNoSymbol = NumberFormat.decimalPattern('id_ID');
final _dateShort = DateFormat('dd MMM yyyy', 'id_ID');

String formatRupiah(int amount) => _idr.format(amount);
String formatRupiahNoSymbol(int amount) => _idrNoSymbol.format(amount);
String formatDateShort(DateTime dt) => _dateShort.format(dt);

class RupiahInputFormatter extends TextInputFormatter {
	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
		// keep only digits
		final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
		if (digits.isEmpty) {
			return const TextEditingValue(text: '', selection: TextSelection.collapsed(offset: 0));
		}
		final number = int.parse(digits);
		final formatted = _idrNoSymbol.format(number);
		return TextEditingValue(
			text: formatted,
			selection: TextSelection.collapsed(offset: formatted.length),
		);
	}
}
