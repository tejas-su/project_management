import 'package:flutter/material.dart';

import '../components/users_section.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 1450, child: UsersSection());
  }
}
