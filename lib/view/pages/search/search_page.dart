// import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';
import 'package:travio/view/widgets/search/search_bar.dart';

import '../../../model/package_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final tripPackageProvider = Provider.of<TripPackageProvider>(context);

    return Scaffold(
      backgroundColor: TTthemeClass().ttSecondary,
      appBar: AppBar(
        backgroundColor: TTthemeClass().ttLightPrimary,
        title: Text(
          'Search',
         style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: TTthemeClass().ttLightText,
              ),
        ),
        iconTheme: IconThemeData(color: TTthemeClass().ttDardPrimary),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TtSearchBar(
              controller: searchProvider.searchController,
              bgColor: Colors.white,
              onChanged: (term) {
                searchProvider.updateSearchTerm(term);
                searchProvider.applyFilters(tripPackageProvider.package);
              },
              onSubmitted: (term) {
                searchProvider.onSearchSubmitted(
                    term, tripPackageProvider.package);
              },
              allPackages: tripPackageProvider.package,
              onSearch: (String) {},
              allPlaces: const [],
            ),
          ),
          Expanded(
            child: _buildBody(context, searchProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchProvider searchProvider) {
    if (searchProvider.searchTerm.isEmpty) {
      if (searchProvider.recentSearches.isEmpty) {
        return _buildEmptyState(TripPackageProvider());
      } else {
        return Column(
          children: [
            _buildRecentSearches(context, searchProvider),
            Expanded(child: _buildEmptyState(TripPackageProvider()))
          ],
        );
      }
    } else if (searchProvider.filteredPackages.isEmpty) {
      return _buildNoResults();
    } else {
      return _buildSearchResults(searchProvider);
    }
  }

  // Widget _buildEmptyState(TripPackageProvider provider) {
  //   return SingleChildScrollView(
  //     child: FutureBuilder(
        
  //       future: Future.wait([
  //         provider.fetchMostBookedPackages(),
  //         provider.fetchAllPackages(),
  //       ]),
  //       builder: (context, snapshot) {
          
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return _buildShimmerEffect();
  //         }
      
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             _buildPackageSection(
  //               title: 'Most Booked Packages',
  //               packages: provider.filteredBookedPackages,
  //             ),
  //             if (provider.filteredBookedPackages.isEmpty)
  //               _buildPackageSection(
  //                 title: 'All Packages',
  //                 packages: provider.package,
  //               ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildPackageSection(
  //     {required String title, required List<TripPackageModel> packages}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Text(
  //           title,
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       packages.isNotEmpty
  //           ? ListView.builder(
  //               shrinkWrap: true,
  //               physics: NeverScrollableScrollPhysics(),
  //               itemCount: packages.length,
  //               itemBuilder: (context, index) {
  //                 final package = packages[index];
  //                 return Padding(
                    
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: PackageCard(
  //                     height: 200,
  //                       image: package.images[index],
  //                       label: package.name,
  //                       package: package),
  //                 );
  //               },
  //             )
  //           : Center(child: Text('No packages available')),
  //     ],
  //   );
  // }

  Widget _buildEmptyState(TripPackageProvider provider) {
  return FutureBuilder(
    future: Future.wait([
      provider.fetchMostBookedPackages(),
      provider.fetchAllPackages(),
    ]),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return _buildShimmerEffect();
      }
      
      return ListView(
        children: [
          _buildPackageSection(
            title: 'Most Booked Packages',
            packages: provider.filteredBookedPackages,
          ),
          if (provider.filteredBookedPackages.isEmpty)
            _buildPackageSection(
              title: 'All Packages',
              packages: provider.package,
            ),
        ],
      );
    },
  );
}

Widget _buildPackageSection({
  required String title,
  required List<TripPackageModel> packages
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      packages.isNotEmpty
          ? Column(
              children: packages.map((package) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: PackageCard(
                  height: 200,
                  image: package.images.isNotEmpty ? package.images[0] : 'assets/images/placeholder.png',
                  label: package.name,
                  package: package,
                ),
              )).toList(),
            )
          : const Center(child: Text('No packages available')),
    ],
  );
}

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentSearches(
      BuildContext context, SearchProvider searchProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchProvider.recentSearches.length,
      itemBuilder: (context, index) {
        final term = searchProvider.recentSearches[index];
        return ListTile(
          leading: Icon(Icons.history, color: TTthemeClass().ttThird),
          title: Text(term),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              searchProvider.removeRecentSearch(term);
            },
          ),
          onTap: () {
            searchProvider.onSearchSubmitted(
              term,
              Provider.of<TripPackageProvider>(context, listen: false)
                  .package,
            );
            searchProvider.searchController.text = term;
          },
        );
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Lottie.asset('assets/animations/NO_search_found.json')),
          const SizedBox(height: 20),
          const Text(
            'No results found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchProvider searchProvider) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (searchProvider.filteredPackages.isNotEmpty) ...[
          const Text(
            'Packages',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...searchProvider.filteredPackages.map(
            (package) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PackageCard(
                height: 150,
                width: double.infinity,
                image: package.images.isNotEmpty
                    ? package.images[0]
                    : 'assets/images/placeholder.png',
                label: package.name,
                package: package,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
