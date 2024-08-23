import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travio/view/widgets/home/package/booking_detail_page.dart';

import '../../../../controller/provider/booking_provider.dart';
import '../../../../core/theme/theme.dart';
import '../../../../model/package_model.dart';
// Import the intl package

class BookingBottomSheet extends StatelessWidget {
  final TripPackageModel tripPackage;

  const BookingBottomSheet({super.key, required this.tripPackage});

  void _showBookingDetailsBottomSheet(
      BuildContext context, BookingProvider bookingProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PackageDetailsBottomSheet(
          tripPackage: tripPackage,
          bookingProvider: bookingProvider,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        final _minAvailableDate = DateTime.now();
        final _maxAvailableDate = _minAvailableDate.add(Duration(days: 365));
        final dateFormat = DateFormat('dd-MM-yyyy'); // Define date format

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Start Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: _minAvailableDate,
                  lastDay: _maxAvailableDate,
                  focusedDay: bookingProvider.rangeStartDate ?? DateTime.now(),
                  selectedDayPredicate: (day) {
                    final startDate = bookingProvider.rangeStartDate;
                    final endDate = bookingProvider.rangeEndDate;
                    return startDate != null &&
                        endDate != null &&
                        day.isAfter(startDate.subtract(Duration(days: 1))) &&
                        day.isBefore(endDate.add(Duration(days: 1)));
                  },
                  rangeStartDay: bookingProvider.rangeStartDate,
                  rangeEndDay: bookingProvider.rangeEndDate,
                  onDaySelected: (selectedDay, focusedDay) {
                    final startDate = selectedDay;
                    final endDate = startDate
                        .add(Duration(days: tripPackage.numberOfDays - 1));

                    if (endDate.isAfter(_maxAvailableDate)) {
                      bookingProvider.setRangeStartDate(startDate);
                      bookingProvider.setRangeEndDate(_maxAvailableDate);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Maximum booking duration is ${tripPackage.numberOfDays} days. End date adjusted to ${dateFormat.format(_maxAvailableDate)}.',
                          ),
                        ),
                      );
                    } else {
                      bookingProvider.setRangeStartDate(startDate);
                      bookingProvider.setRangeEndDate(endDate);
                    }
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: TTthemeClass().ttThird.withOpacity(0.5),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    rangeHighlightColor:
                        TTthemeClass().ttThird.withOpacity(0.4),
                    selectedDecoration: BoxDecoration(
                      color: TTthemeClass().ttThird,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.red),
                    holidayTextStyle: TextStyle(color: Colors.green),
                    defaultTextStyle: TextStyle(color: Colors.black),
                    outsideDaysVisible: false,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Number of People',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${bookingProvider.numberOfPeople} People',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (bookingProvider.numberOfPeople > 1) {
                              bookingProvider.setNumberOfPeople(
                                  bookingProvider.numberOfPeople - 1);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            bookingProvider.setNumberOfPeople(
                                bookingProvider.numberOfPeople + 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price: ',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\₹${bookingProvider.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showBookingDetailsBottomSheet(context, bookingProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TTthemeClass().ttButton,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Continue',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
