import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/package_provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import 'package:travio/core/theme/theme.dart';
import 'package:travio/view/widgets/home/package/package_card.dart';
import 'package:travio/view/widgets/search/search_bar.dart';

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
          style: TextStyle(color: TTthemeClass().ttDardPrimary),
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
              onSearch: (String) {}, allPlaces: [],
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
        return _buildEmptyState();
      } else {
        return _buildRecentSearches(context, searchProvider);
      }
    } else if (searchProvider.filteredPackages.isEmpty) {
      return _buildNoResults();
    } else {
      return _buildSearchResults(searchProvider);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/empty_search.svg',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context, SearchProvider searchProvider) {
    return ListView.builder(
      itemCount: searchProvider.recentSearches.length,
      itemBuilder: (context, index) {
        final term = searchProvider.recentSearches[index];
        return ListTile(
          leading: Icon(Icons.history, color: TTthemeClass().ttThird),
          title: Text(term),
          trailing: IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              searchProvider.removeRecentSearch(term);
            },
          ),
          onTap: () {
            searchProvider.onSearchSubmitted(
              term,
              Provider.of<TripPackageProvider>(context, listen: false).package,
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
          SvgPicture.asset(
            'assets/images/no_results.svg',
            width: 200,
            height: 200,
          ),
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
