import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  DateTime? _selectedDate;
  DateTime? _rangeStartDate;
  DateTime? _rangeEndDate;
  int _numberOfPeople = 1;
  double _pricePerPerson = 0.0;
  String? _packageId; // To track the selected package ID

  DateTime? get selectedDate => _selectedDate;
  DateTime? get rangeStartDate => _rangeStartDate;
  DateTime? get rangeEndDate => _rangeEndDate;
  int get numberOfPeople => _numberOfPeople;
  double get totalPrice => _pricePerPerson * _numberOfPeople;
  String? get packageId => _packageId; // Getter for the package ID

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

  void updateBookingDatesBasedOnPackage(int numberOfDays) {
    DateTime startDate = _selectedDate ?? DateTime.now();
    DateTime endDate = startDate.add(Duration(days: numberOfDays - 1));

    _rangeStartDate = startDate;
    _rangeEndDate = endDate;

    notifyListeners();
  }

  void resetBookingState() {
    _selectedDate = null;
    _rangeStartDate = null;
    _rangeEndDate = null;
    _numberOfPeople = 1;
    _packageId = null; // Reset the package ID when resetting state
    notifyListeners();
  }

  void setPackageId(String? id) {
    _packageId = id;
    notifyListeners();
  }
}
