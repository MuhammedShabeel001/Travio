import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/search/search_bar.dart';

import '../../widgets/search/empty_state.dart';
import '../../widgets/search/no_results.dart';
import '../../widgets/search/recent_searches.dart';
import '../../widgets/search/search_results.dart';
import '../../widgets/search/shimmer_effect.dart';
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
          style: TextStyle(
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
                searchProvider.onSearchSubmitted(term, tripPackageProvider.package);
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
        return _buildEmptyState(Provider.of<TripPackageProvider>(context));
      } else {
        return Column(
          children: [
            const RecentSearches(),
            Expanded(child: _buildEmptyState(Provider.of<TripPackageProvider>(context))),
          ],
        );
      }
    } else if (searchProvider.filteredPackages.isEmpty) {
      return const NoResults();
    } else {
      return SearchResults(searchProvider: searchProvider);
    }
  }

  Widget _buildEmptyState(TripPackageProvider provider) {
    return FutureBuilder(
      future: Future.wait([
        provider.fetchMostBookedPackages(),
        provider.fetchAllPackages(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerEffect();
        }

        return ListView(
          children: [
            PackageSection(
              title: 'Most Booked Packages',
              packages: provider.filteredBookedPackages,
            ),
            if (provider.filteredBookedPackages.isEmpty)
              PackageSection(
                title: 'All Packages',
                packages: provider.package,
              ),
          ],
        );
      },
    );
  }
}
