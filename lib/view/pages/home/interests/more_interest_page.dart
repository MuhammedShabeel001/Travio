import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travio/view/pages/home/interests/interest_detail_page.dart';

class ActivityCategory {
  final String name;
  final String imageUrl;

  ActivityCategory({required this.name, required this.imageUrl});
}

class ActivityCategoriesPage extends StatelessWidget {
  final List<ActivityCategory> categories = [
    ActivityCategory(name: 'Hiking', imageUrl: 'assets/images/hicking.png'),
    ActivityCategory(name: 'Camping', imageUrl: 'assets/images/camping.png'), 
    ActivityCategory(name: 'Beach', imageUrl: 'assets/images/beach.png'),
    ActivityCategory(name: 'Cycling', imageUrl: 'assets/images/cycling.png'),
    ActivityCategory(name: 'Sightseeing', imageUrl: 'assets/images/sightseeing.png'),
    ActivityCategory(name: 'Adventure Sports', imageUrl: 'assets/images/adventure_sports.png'),
    ActivityCategory(name: 'Wildlife Safari', imageUrl: 'assets/images/wildlife_safari.png'),
    ActivityCategory(name: 'Skiing', imageUrl: 'assets/images/skiing.png'), 
    ActivityCategory(name: 'Cultural Experience', imageUrl: 'assets/images/cultural_experience.png'),
    ActivityCategory(name: 'Culinary Tours', imageUrl: 'assets/images/culinary_tours.png'),
    ActivityCategory(name: 'Water Sports', imageUrl: 'assets/images/water_sports.png'),
    ActivityCategory(name: 'Wellness and Spa', imageUrl: 'assets/images/wellness_spa.png'),
    ActivityCategory(name: 'Photograph', imageUrl: 'assets/images/photography.png'), 
    ActivityCategory(name: 'Road Trips', imageUrl: 'assets/images/road_trips.png'),
    ActivityCategory(name: 'Cruise', imageUrl: 'assets/images/cruise.png'), 
    ActivityCategory(name: 'Historical Tours', imageUrl: 'assets/images/histrical.png'),
    ActivityCategory(name: 'Luxury Travel', imageUrl: 'assets/images/luxuary.png'),
    ActivityCategory(name: 'Festival and Events', imageUrl: 'assets/images/festival_events.png'),
    ActivityCategory(name: 'Eco-Tourism', imageUrl: 'assets/images/eco_friendly.png'),
    ActivityCategory(name: 'Family-Friendly', imageUrl: 'assets/images/family_friendly.png'),
    ActivityCategory(name: 'Volunteer Travel', imageUrl: 'assets/images/volunteer.png'),
    ActivityCategory(name: 'Shopping', imageUrl: 'assets/images/shopping.png'),
    ActivityCategory(name: 'Religious and Spiritual Tours', imageUrl: 'assets/images/spiritual_tours.png'),
    ActivityCategory(name: 'Nightlife and Entertainment', imageUrl: 'assets/images/night_life.png'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            childAspectRatio: 0.75, // Adjust this for the shape (1.0 for square)
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => InterestDetailPage(
                      interest: categories[index].name,
                    ),
                  ),
                );
                // Handle tap event, e.g., navigate to category details
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        categories[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0,
                      child: Text(
                        categories[index].name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}