import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travio/controller/provider/search_provider.dart';
import 'package:travio/core/theme/theme.dart';

import '../../../controller/provider/package_provider.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

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
              Provider.of<TripPackageProvider>(context, listen: false).package,
            );
            searchProvider.searchController.text = term;
          },
        );
      },
    );
  }
}
