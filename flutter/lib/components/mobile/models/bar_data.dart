import 'dart:ui';
 
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class BarData {
  const BarData(this.color, this.value, this.shadowValue, this.subject, this.date);
  final Color color;
  final double value;
  final double shadowValue;
  final String subject;
  final DateTime date;
}