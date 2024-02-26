import 'package:flutter/material.dart';
import 'package:project_management/presentation/components/project_section.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 1450, child: ProjectSection());
  }
}
