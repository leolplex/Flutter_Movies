import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selected = "";
  final movies = [
    'Spiderman',
    'Auaman',
    'Batman',
    'Shazam!',
    'Captain America'
  ];
  final lastMovies = ['Spiderman', 'Captain America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions of our APPBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon lef from NavBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Create the results to show
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions to show when somebody writes

    final suggestList = (query.isEmpty)
        ? lastMovies
        : movies
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestList[i]),
          onTap: () {
            selected = suggestList[i];
            showResults(context);
          },
        );
      },
      itemCount: suggestList.length,
    );
  }
}
