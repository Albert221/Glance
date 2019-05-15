import 'package:flutter/material.dart';

class SearchSubredditsDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => showResults(context),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => const BackButton();

  @override
  Widget buildResults(BuildContext context) {
    final results = List.generate(3, (i) => query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, i) {
        final result = results[i];

        return ListTile(
          leading: const CircleAvatar(),
          title: Text('r/$result'),
          onTap: () => close(context, result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => ListView();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final superTheme = super.appBarTheme(context);

    return superTheme.copyWith(
      textTheme: superTheme.textTheme.copyWith(
        title: superTheme.textTheme.title.copyWith(
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
