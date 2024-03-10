import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_management/models/projects_model.dart';
import 'package:project_management/presentation/screens/imports.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchScreen extends StatefulWidget {
  final SupabaseClient supabase;
  const SearchScreen({super.key, required this.supabase});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    HelperFunctions helperFunctions = HelperFunctions();

    //search term controller
    TextEditingController searchTerm = TextEditingController();
    TabController tabcontroller = TabController(length: 3, vsync: this);
    List images = [
      "assets/avatars/man (1).png",
      "assets/avatars/man (2).png",
      "assets/avatars/man (3).png",
      "assets/avatars/man (4).png",
      "assets/avatars/man (5).png",
    ];

    search(String tableName, String query, context, supabase) {
      helperFunctions
          .searchInProjectTable(supabase); //tableName, query, context,
    }

    return Row(
      children: [
        Container(
          width: 700,
          decoration: const BoxDecoration(color: whiteBG),
          child: Column(
            children: [
              //search field implementation
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: whiteContainer,
                    ),
                    child: TextField(
                      controller: searchTerm,
                      onChanged: (value) {
                        search(tabcontroller.toString(), searchTerm.toString(),
                            context, widget.supabase);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
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
                    // Text(
                    //   "Users",
                    //   style: TextStyle(fontSize: 25),
                    // ),
                    Text("Projects", style: TextStyle(fontSize: 25)),
                    // Text("Projects with Bugs", style: TextStyle(fontSize: 25))
                  ]),
              Expanded(
                child: TabBarView(controller: tabcontroller, children: [
                  // //!Users screen
                  // SizedBox(
                  //   child: GridView.builder(
                  //       itemCount: 5,
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3,
                  //       ),
                  //       scrollDirection: Axis.vertical,
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           margin: const EdgeInsets.all(16),
                  //           color: whiteContainer,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     top: 10.0, left: 4, bottom: 2),
                  //                 child: ListTile(
                  //                   leading: CircleAvatar(
                  //                     radius: 30,
                  //                     child: Image.asset(
                  //                       images[index],
                  //                     ),
                  //                   ),
                  //                   title: const Text("username"),
                  //                   subtitle: const Text("use_designation"),
                  //                 ),
                  //               ),
                  //               const Padding(
                  //                 padding: EdgeInsets.only(
                  //                     top: 10.0, left: 25, bottom: 2),
                  //                 child: Text("Team : team_name"),
                  //               ),
                  //               const Padding(
                  //                 padding: EdgeInsets.only(
                  //                     top: 10.0, left: 25, bottom: 2),
                  //                 child: Text("Project : project_name"),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // ),
                  //Projects  screen
                  FutureBuilder(
                      future: helperFunctions
                          .searchInProjectTable(supabase), //'projects',
                      // 'project',
                      // context,
                      builder:
                          (context, AsyncSnapshot<List<project>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Lottie.asset('lottie/ani1.json', height: 500);
                        } else if (snapshot.hasError) {
                          return showErrorDialog(
                              context, 'error in retriewing data');
                        } else if (snapshot.data!.isEmpty) {
                          return const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusColor: whiteContainer,
                                hoverColor: whiteContainer,
                                autofocus: true,
                                selected: true,
                                selectedColor: black,
                                selectedTileColor: whiteContainer,
                                enabled: true,
                                tileColor: whiteBG,
                                leading: CircleAvatar(
                                    child: Text('😒',
                                        style: TextStyle(fontSize: 30))),
                                title: Text(
                                  'Feels like everything\'s good ',
                                  style: TextStyle(fontSize: 15),
                                ),
                                subtitle: Text(
                                  'No bugs found, 🥳 ',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasData) {
                          final data = snapshot.data;
                          return SizedBox(
                            child: GridView.builder(
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  //List<Row> rows = snapshot.data as List<Row>;
                                  //  for (Row row in rows) {
                                  //   String TEAMNAE = row.children[index].toString();
                                  //   print('Required team name from row $index is $TEAMNAE');
                                  //  }
                                  final searchdata = data![index];
                                  return Container(
                                    margin: const EdgeInsets.all(25),
                                    color: whiteContainer,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 4, bottom: 2),
                                          child: ListTile(
                                            // leading: CircleAvatar(
                                            //   radius: 30,
                                            //   child: Image.asset(
                                            //     images[index],
                                            //   ),
                                            // ), // Iterate through rows

                                            title: Text(
                                                "Team :${searchdata.projectName} "),
                                            //subtitle: const Text("team lead"),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 25, bottom: 2),
                                          child: Text("Project : "),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 25, bottom: 2),
                                          child: Text("description :"),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        } else {
                          throw e;
                          // const ListTile(
                          //   shape: const BeveledRectangleBorder(
                          //       borderRadius: BorderRadius.all(Radius.circular(10))),
                          //   focusColor: whiteContainer,
                          //   hoverColor: whiteContainer,
                          //   autofocus: true,
                          //   //selected: selected,
                          //   selectedColor: black,
                          //   selectedTileColor: whiteContainer,
                          //   enabled: true,
                          //   tileColor: whiteBG,
                          //   leading: const CircleAvatar(
                          //       child: Text('😒',
                          //       style: TextStyle(fontSize: 30))),
                          //   title: const Text('Add a project',
                          //     style:TextStyle(fontSize: 12),
                          //   ),
                          // );
                        }
                      }

                      // //!Projects with Bugs screen
                      // SizedBox(
                      //   child: GridView.builder(
                      //       itemCount: 5,
                      //       gridDelegate:
                      //           const SliverGridDelegateWithFixedCrossAxisCount(
                      //               crossAxisCount: 3, childAspectRatio: .9
                      //               //crossAxisSpacing: 25,
                      //               //mainAxisSpacing: 25,
                      //               //mainAxisExtent: 200
                      //               ),
                      //       scrollDirection: Axis.vertical,
                      //       itemBuilder: (context, index) {
                      //         return Expanded(
                      //           child: Container(
                      //             margin: const EdgeInsets.all(25),
                      //             color: whiteContainer,
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       top: 10.0, left: 4, bottom: 2),
                      //                   child: ListTile(
                      //                     leading: CircleAvatar(
                      //                       radius: 30,
                      //                       child: Image.asset(
                      //                         images[index],
                      //                       ),
                      //                     ),
                      //                     title: const Text("Abhay B Prabhu"),
                      //                     subtitle: const Text("team lead"),
                      //                   ),
                      //                 ),
                      //                 const Padding(
                      //                   padding: EdgeInsets.only(
                      //                       top: 10.0, left: 25, bottom: 1),
                      //                   child: Text("Team : Kraken"),
                      //                 ),
                      //                 const Padding(
                      //                   padding: EdgeInsets.only(
                      //                       top: 10.0, left: 25, bottom: 1),
                      //                   child: Text("Project : Lady_Bug"),
                      //                 ),
                      //                 const Padding(
                      //                   padding: EdgeInsets.only(
                      //                     top: 10.0,
                      //                     left: 25,
                      //                   ),
                      //                   child: Text("Bugs : 2"),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      // ),
                      )
                ]),
              ),
            ],
          ),
        ),

        //!Description
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              width: 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteContainer,
              ),
              child: Column(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/avatars/man (1).png",
                          ),
                        ),
                        title: const Text(
                          "User name",
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: const Text("user_email"),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("All details..."),
                              Text("user_designation"),
                              Text("team_name"),
                              Text("Project: project_name"),
                              Text("Project: project_description"),
                              Text("Bug : Bug_description"),
                              Text("Bug Description:"),
                              Text(
                                  "Bug Description......Bug Description\nBug Description......Bug Description\nBug Description......Bug Description"),
                              Text("Bug status")
                            ],
                          ),
                        ),
                      ),
                    ]),
              ])),
        )
      ],
    );
  }
}
