import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const String dateFormatter = 'MMMM dd, y';
const String timeFormatter = 'hh:mm:ss';
extension DateHelper on DateTime {

  /// Format date example June 23, 2022
  String formatDate() {
    final DateFormat formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }



  String formatTime() {
    final DateFormat formatter = DateFormat(timeFormatter);
    final String dateTime = formatter.add_jm().format(this);
    final String timeOnly = '${dateTime.split(' ')[1]} ${dateTime.split(' ')[2]}';
    return timeOnly;
  }
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final DateTime now = DateTime.now();
    return now.difference(this).inDays;
  }
}

class DataFormatter{
  static String formatDate(String dateString){
    //2022-01-21T05:00:00Z
    if(dateString.isEmpty) {
      return dateString;
    }else{
    final DateTime now = DateTime.parse(dateString);
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    return formattedDate;

    }
  }

  /*static String relativeDateFormat(String date){
    // 9 years ago
    if(date == '') {
      return date;
    }
    return Jiffy(date, 'yyyy-MM-dd').fromNow();
  }*/

    ///'Wednesday, January 10, 2012'
  static String formatDateToString(String date){
    if(date == '') {
      return date;
    }
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat.yMMMMEEEEd().format(parsedDate);
  }

  static String formatDateAndTimeToString(String dateString){
    final DateTime now = DateTime.parse(dateString);
    final String formattedDateToString = DateFormat('EE MMMM dd, yyyy HH:mm').format(now);
    return formattedDateToString;
  }

  static String formatDateAndTimeToStringDigit(String dateString){
    final DateTime now = DateTime.parse(dateString);
    final String formattedDateToString = DateFormat('dd-MM-yyyy HH:mm').format(now);
    return formattedDateToString;
  }

 static String formatDateOnly(DateTime date) {
    final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
    return dateFormatter.format(date);
  }


  static String formatDigitGrouping(double num){
    final List<String> value = <String>[];
    final NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final String number = num.toStringAsFixed(2);
    final String wholeNumber = number.split('.')[0];
    final String decimalNumber = number.split('.')[1];
    final double formattedNumber = double.parse(wholeNumber);
    final String numberInString =  myFormat.format(formattedNumber);
    value.add(numberInString);
    value.add(decimalNumber);
    final String digit = value.join('.');
    return digit;
  }
  static NumberFormat getLocalCurrencyFormatter(BuildContext context, {bool includeSymbol = true}){
    final NumberFormat formatter = NumberFormat.currency(
        locale: Localizations.localeOf(context).toString(),name:'Ghana Cedis',
        symbol: includeSymbol ? 'GH¢ ' : '',decimalDigits: 2);
    return formatter;
  }
  static NumberFormat getCurrencyFormatter(BuildContext context){
    final NumberFormat formatter = NumberFormat.currency(
        locale: Localizations.localeOf(context).toString(),name:'Ghana Cedis',
        symbol: '',decimalDigits: 2);
    return formatter;
  }
}