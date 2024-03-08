import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_management/presentation/helper_functions/helper_functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BugsSection extends StatefulWidget {
  final String projectname;
  const BugsSection({
    Key? key,
    required this.projectname, //the project name selected by user
  }) : super(key: key);

  @override
  State<BugsSection> createState() => _BugsSectionState();
}

class _BugsSectionState extends State<BugsSection> {
  @override
  Widget build(BuildContext context) {
    HelperFunctions helperFunctions = HelperFunctions();
    final supabase = Supabase.instance.client;
    return FutureBuilder(
        future: helperFunctions.getBugsForProject(
            context, supabase, widget.projectname.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('');
          } else if (snapshot.hasError) {
            return showErrorDialog(context, 'Error in retreiving data');
          } else {
            final bugs = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final bug = bugs![index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('${bug.bugsName}'),
                      subtitle: Text(
                        'Bug status: ${bug.bugStatus}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        'created date: ${bug.dateCreated}',
                      ),
                      horizontalTitleGap: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${bug.bugsDescription}',
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                );
              },
              itemCount: 1,
            );
          }
        });
  }
}
