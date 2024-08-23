import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  DateTime? _selectedDate;
  DateTime? _rangeStartDate;
  DateTime? _rangeEndDate;
  int _numberOfPeople = 1;
  double _pricePerPerson = 0.0; // This will be updated from the trip package

  DateTime? get selectedDate => _selectedDate;
  DateTime? get rangeStartDate => _rangeStartDate;
  DateTime? get rangeEndDate => _rangeEndDate;
  int get numberOfPeople => _numberOfPeople;
  double get totalPrice => _pricePerPerson * _numberOfPeople;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setRangeStartDate(DateTime? date) {
    _rangeStartDate = date;
    notifyListeners();
  }

  void setRangeEndDate(DateTime? date) {
    _rangeEndDate = date;
    notifyListeners();
  }

  void setNumberOfPeople(int number) {
    _numberOfPeople = number;
    notifyListeners();
  }

  void updatePrice(double price) {
    _pricePerPerson = price;
    notifyListeners();
  }

  void resetBookingState() {
    _selectedDate = null;
    _rangeStartDate = null;
    _rangeEndDate = null;
    _numberOfPeople = 1;
    // Optionally reset the price per person if needed
    // _pricePerPerson = 0.0;
    notifyListeners();
  }

  // void resetState() {
  //   _selectedDate = null;
  //   _rangeStartDate = null;
  //   _rangeEndDate = null;
  //   _numberOfPeople = 1;
  //   // _pricePerPerson = 0.0;
  //   notifyListeners();
  // }
}
