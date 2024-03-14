import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_management/models/bugs_model.dart';
import 'package:project_management/models/projects_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/users_model.dart';
import 'imports.dart';

class SearchScreen extends StatefulWidget {
  final SupabaseClient supabase;
  const SearchScreen({super.key, required this.supabase});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  //search term controller
  TextEditingController searchTerm = TextEditingController();

  //List to store the data of  searched item
  List<users> userSearchResults = [];
  List<project> projectSearchResults = [];
  List<bugs> bugSearchResults = [];

  TabController? tabcontroller;
  void search() async {
    //search in user table
    var usearchResult = await HelperFunctions()
        .searchInUserTable(searchTerm.text, context, widget.supabase) as List;
    setState(() {
      userSearchResults = usearchResult as List<users>;
    });

    //search in project table
    var psearchResult = await HelperFunctions().searchInProjectTable(
        searchTerm.text, context, widget.supabase) as List;
    setState(() {
      projectSearchResults = psearchResult as List<project>;
    });

    //search in bugs table
    var bsearchResult = await HelperFunctions()
        .searchInBugsTable(searchTerm.text, context, widget.supabase) as List;
    setState(() {
      bugSearchResults = bsearchResult as List<bugs>;
    });
    // }
  }

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    searchTerm.dispose();
    tabcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    ////User icons
    List userIcon = [
      "assets/avatars/man (1).png",
      "assets/avatars/man (2).png",
      "assets/avatars/man (3).png",
      "assets/avatars/man (4).png",
      "assets/avatars/man (5).png",
    ];

    //Project icons
    List projectIcon = [
      "assets/projects/p1.png",
      "assets/projects/p2.png",
    ];

    //Bugs icons
    List bugIcon = [
      "assets/bugs/b1.png",
    ];

    return Row(children: [
      Container(
          width: width - 200,
          decoration: const BoxDecoration(color: whiteBG),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 700,
                    decoration: const BoxDecoration(color: whiteBG),
                    child: Column(children: [
                      //search field implementation
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: whiteContainer,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: searchTerm,
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  suffixIcon: IconButton(
                                      onPressed: search,
                                      icon: const Icon(Icons.search)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )),
                    ]))
              ],
            ),
            TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                tabAlignment: TabAlignment.center,
                splashBorderRadius: BorderRadius.circular(16),
                indicator: BoxDecoration(
                    color: whiteContainer,
                    borderRadius: BorderRadius.circular(12)),
                controller: tabcontroller,
                tabs: const [
                  Text("Users", style: TextStyle(fontSize: 25)),
                  Text("Projects", style: TextStyle(fontSize: 25)),
                  Text("Bugs", style: TextStyle(fontSize: 25)),
                ]),
            Expanded(
                child: TabBarView(controller: tabcontroller, children: [
              //users search tab
              if (userSearchResults.isNotEmpty)
                SizedBox(
                    child: GridView.builder(
                        itemCount: userSearchResults.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final searchdata = userSearchResults[index];
                          return Container(
                            margin: const EdgeInsets.all(25),
                            color: whiteContainer,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 4, bottom: 2),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        userIcon[Random().nextInt(5)],
                                      ),
                                    ), // Iterate through rows

                                    title:
                                        Text("Name: ${searchdata.userName} "),
                                    subtitle: Text("${searchdata.userEmail}"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Designation: ${searchdata.userDesignation}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Project: ${searchdata.projectName} "),
                                )
                              ],
                            ),
                          );
                        }))
              else
                Container(
                  alignment: Alignment.center,
                  child: const Text("No results found"),
                ),

              //projects search tab
              if (projectSearchResults.isNotEmpty)
                SizedBox(
                    child: GridView.builder(
                        itemCount: projectSearchResults.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final searchdata = projectSearchResults[index];
                          return Container(
                            margin: const EdgeInsets.all(25),
                            color: whiteContainer,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 4, bottom: 2),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        projectIcon[Random().nextInt(1)],
                                      ),
                                    ), // Iterate through rows

                                    title: Text(
                                        "Project: ${searchdata.projectName} "),
                                    subtitle:
                                        Text("Team: ${searchdata.teamName}"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Date created: ${searchdata.dateCreated}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Description :${searchdata.projectDescription}"),
                                )
                              ],
                            ),
                          );
                        }))
              else
                Container(
                  alignment: Alignment.center,
                  child: const Text("No results found"),
                ),

              //bugs search tab
              if (bugSearchResults.isNotEmpty)
                SizedBox(
                    child: GridView.builder(
                        itemCount: bugSearchResults.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final searchdata = bugSearchResults[index];
                          return Container(
                            margin: const EdgeInsets.all(25),
                            color: whiteContainer,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 4, bottom: 2),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        bugIcon[0],
                                      ),
                                    ), // Iterate through rows

                                    title: Text(
                                        "Bug title: ${searchdata.bugsName}"),
                                    subtitle:
                                        Text("Status: ${searchdata.bugStatus}"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Project :${searchdata.projectName} "),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Date created:${searchdata.dateCreated}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Updated date:${searchdata.updateDate} "),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text(
                                      "Description: ${searchdata.bugsDescription}"),
                                )
                              ],
                            ),
                          );
                        }))
              else
                Container(
                  alignment: Alignment.center,
                  child: const Text("No results found"),
                )
            ]))
          ]))
    ]);
  }
}
