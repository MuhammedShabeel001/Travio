import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  DateTime? _selectedDate;
  DateTime? _rangeStartDate;
  DateTime? _rangeEndDate;
  int _numberOfPeople = 1;
  double _pricePerPerson = 0.0;
  String? _packageId; 

  DateTime? get selectedDate => _selectedDate;
  DateTime? get rangeStartDate => _rangeStartDate;
  DateTime? get rangeEndDate => _rangeEndDate;
  int get numberOfPeople => _numberOfPeople;
  double get totalPrice => _pricePerPerson * _numberOfPeople;
  String? get packageId => _packageId;

  /// Sets the selected date for the booking.
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  /// Sets the start date for the booking range.
  void setRangeStartDate(DateTime? date) {
    if (date != null && (_rangeEndDate == null || date.isBefore(_rangeEndDate!))) {
      _rangeStartDate = date;
      notifyListeners();
    }
  }

  /// Sets the end date for the booking range.
  void setRangeEndDate(DateTime? date) {
    if (date != null && (_rangeStartDate == null || date.isAfter(_rangeStartDate!))) {
      _rangeEndDate = date;
      notifyListeners();
    }
  }

  /// Updates the number of people for the booking.
  void setNumberOfPeople(int number) {
    if (number > 0) {
      _numberOfPeople = number;
      notifyListeners();
    }
  }

  /// Updates the price per person.
  void updatePrice(double price) {
    _pricePerPerson = price;
    notifyListeners();
  }

  /// Updates booking dates based on the number of days.
  void updateBookingDatesBasedOnPackage(int numberOfDays) {
    if (numberOfDays > 0) {
      DateTime startDate = _selectedDate ?? DateTime.now();
      DateTime endDate = startDate.add(Duration(days: numberOfDays - 1));

      _rangeStartDate = startDate;
      _rangeEndDate = endDate;

      notifyListeners();
    }
  }

  /// Resets all booking-related state to default values.
  void resetBookingState() {
    _selectedDate = null;
    _rangeStartDate = null;
    _rangeEndDate = null;
    _numberOfPeople = 1;
    _packageId = null; // Reset the package ID when resetting state
    notifyListeners();
  }

  /// Sets the package ID for the booking.
  void setPackageId(String? id) {
    _packageId = id;
    notifyListeners();
  }
}
