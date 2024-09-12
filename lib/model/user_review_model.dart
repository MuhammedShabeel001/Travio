class Review {
  final String userName;
  final String userProfileUrl;
  final String review;

  Review({
    required this.userName,
    required this.userProfileUrl,
    required this.review,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      userName: map['userName'] ?? '',
      userProfileUrl: map['userProfileUrl'] ?? '',
      review: map['review'] ?? '',
    );
  }
}