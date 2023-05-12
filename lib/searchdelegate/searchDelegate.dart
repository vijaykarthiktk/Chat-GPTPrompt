import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../const/const.dart';
import '../screen/promptShow.dart';

class PromptSearch extends SearchDelegate<String> {
  final List<String> acts;
  final List<String> prompts;


  PromptSearch(this.acts, this.prompts);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Add search icon and clear text icon to the search bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Add back arrow to the search bar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the search results based on the query string
    final results = acts.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);

            query = results[index];

            Navigator.push(context, SwipeablePageRoute(
              builder: (context) => PromptScreen( act: query, prompt: prompts[acts.indexOf(query)],),
            ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show the suggestions based on the query string
    final suggestions = acts.where((item) => item.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];

            showResults(context);
            close(context, query);
            Navigator.push(context, SwipeablePageRoute(
              builder: (context) => PromptScreen( act: query, prompt: prompts[acts.indexOf(query)],),
            ));
          },
        );
      },
    );
  }
}
