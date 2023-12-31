import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostelway/services/search_places_service.dart';
import 'package:uuid/uuid.dart';

class SearchPlacesField extends SearchDelegate<Suggestion> {
  final StreamController<List<Suggestion>> _resultsController =
      StreamController<List<Suggestion>>();
  Timer? _debounceTimer;

  SearchPlacesField();

  _searchPlace() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 700), () async {
      if (query.isNotEmpty) {
        final results =
            await PlaceApiProvider(const Uuid().v4()).fetchSuggestions(query);

        _resultsController.add(results);
      } else {
        _resultsController.add([]);
      }
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Результаты поиска: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _searchPlace();

    return StreamBuilder(
      stream: _resultsController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Нет результатов поиска'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  close(context, snapshot.data![index]);
                },
                title: Text(snapshot.data![index].description),
                // Дополнительные настройки для элементов списка
              );
            },
          );
        }
      },
    );
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    _debounceTimer?.cancel();
    _resultsController.close();
  }
}
