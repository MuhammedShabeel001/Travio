import 'package:travio/model/review_model.dart';

class TripPackageModel {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final Map<int, String> dailyPlan;
  final double realPrice;
  final double offerPrice;
  final List<String> activities;
  final List<String> transportOptions;
  final int numberOfDays;
  final int numberOfNights;
  final int bookedCount;
  final int likeCount;
  final int totalDays;
  final double ratingCount;
  final List<String> locations;
  final Set<String> likedByUserIds;
  List<ReviewModel> reviews;

  TripPackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.dailyPlan,
    required this.realPrice,
    required this.offerPrice,
    required this.activities,
    required this.transportOptions,
    required this.numberOfDays,
    required this.numberOfNights,
    required this.bookedCount,
    required this.likeCount,
    required this.totalDays,
    required this.ratingCount,
    this.reviews = const [],
    required this.locations,
    required this.likedByUserIds,
  });

  factory TripPackageModel.fromMap(Map<String, dynamic> map) {
    final dailyPlanData = map['daily_plan'];
    Map<int, String> dailyPlan = {};

    if (dailyPlanData is Map<String, dynamic>) {
      dailyPlan = dailyPlanData.map(
        (key, value) => MapEntry(int.tryParse(key) ?? 0, value as String),
      );
    } else if (dailyPlanData is List<dynamic>) {
      for (int i = 0; i < dailyPlanData.length; i++) {
        dailyPlan[i] = dailyPlanData[i] as String;
      }
    }

    return TripPackageModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      images: List<String>.from(map['images'] as List<dynamic>? ?? []),
      dailyPlan: dailyPlan,
      realPrice: (map['real_price'] as num).toDouble(),
      offerPrice: (map['offer_price'] as num).toDouble(),
      activities: List<String>.from(map['activities'] as List<dynamic>? ?? []),
      transportOptions:
          List<String>.from(map['transport_options'] as List<dynamic>? ?? []),
      numberOfDays: map['number_of_days'] as int,
      numberOfNights: map['number_of_nights'] as int,
      bookedCount: map['booked_count'] as int? ?? 0,
      likeCount: map['like_count'] as int? ?? 0,
      totalDays: map['total_number_of_days'] as int,
      ratingCount: (map['rating_count'] as num?)?.toDouble() ?? 0.0,
      reviews: [],
      locations: List<String>.from(map['locations'] as List<dynamic>? ?? []),
      likedByUserIds: Set<String>.from(map['liked_by_user_ids'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'daily_plan': dailyPlan,
      'real_price': realPrice,
      'offer_price': offerPrice,
      'activities': activities,
      'transport_options': transportOptions,
      'number_of_days': numberOfDays,
      'number_of_nights': numberOfNights,
      'booked_count': bookedCount,
      'like_count': likeCount,
      'total_number_of_days': totalDays,
      'rating_count': ratingCount,
      'locations': locations,
      'liked_by_user_ids': likedByUserIds.toList(),
    };
  }

  TripPackageModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    Map<int, String>? dailyPlan,
    double? realPrice,
    double? offerPrice,
    List<String>? activities,
    List<String>? transportOptions,
    int? numberOfDays,
    int? numberOfNights,
    int? bookedCount,
    int? likeCount,
    int? totalDays,
    double? ratingCount,
    List<ReviewModel>? reviews,
    List<String>? locations,
    Set<String>? likedByUserIds,
  }) {
    return TripPackageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      dailyPlan: dailyPlan ?? this.dailyPlan,
      realPrice: realPrice ?? this.realPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      activities: activities ?? this.activities,
      transportOptions: transportOptions ?? this.transportOptions,
      numberOfDays: numberOfDays ?? this.numberOfDays,
      numberOfNights: numberOfNights ?? this.numberOfNights,
      bookedCount: bookedCount ?? this.bookedCount,
      likeCount: likeCount ?? this.likeCount,
      totalDays: totalDays ?? this.totalDays,
      ratingCount: ratingCount ?? this.ratingCount,
      reviews: reviews ?? this.reviews,
      locations: locations ?? this.locations,
      likedByUserIds: likedByUserIds ?? this.likedByUserIds,
    );
  }
}
