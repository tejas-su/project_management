import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchScreen extends StatefulWidget {
  final SupabaseClient supabase;
  const SearchScreen({super.key, required this.supabase});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 700,
        )
      ],
    );
  }
}
