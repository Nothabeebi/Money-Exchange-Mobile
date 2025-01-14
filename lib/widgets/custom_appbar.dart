import 'dart:ui';

import 'package:flutter/material.dart';

class AwesomeBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;
  final String? searchHint;
  final Function(String)? onSearch;

  const AwesomeBar({
    super.key,
    required this.title,
    required this.onLogout,
    this.searchHint,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color(0xFF4CAF50),
      actions: [
        if (onSearch != null)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _SearchDelegate(onSearch: onSearch!),
              );
            },
          ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: onLogout,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _SearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  _SearchDelegate({required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
