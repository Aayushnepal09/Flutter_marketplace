import 'package:KinBech/theme/theme_data.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: COLOR_PRIMARY,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: COLOR_SECONDARY, borderRadius: BorderRadius.circular(25)),
        child: TextField(
          decoration: InputDecoration(
            filled: false,
            hintText: "Search",
            suffixIcon: IconButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/landingsearch'),
              icon: Icon(
                Icons.search,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
