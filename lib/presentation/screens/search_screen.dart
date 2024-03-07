import 'package:flutter/material.dart';
import 'package:project_management/models/users_model.dart';
import 'package:project_management/presentation/themes/themes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 3, vsync: this);
    List images = [
      "assets/avatars/man (1).png",
      "assets/avatars/man (2).png",
      "assets/avatars/man (3).png",
      "assets/avatars/man (4).png",
      "assets/avatars/man (5).png",
    ];

    // final supabase = Supabase.instance.client;
    // String search_term = 'user1';

    // Future<List<users>> Search_users(String search_term) async{
    //   final response = await supabase.from('users').select();
      
    //   // if(_response.isEmpty != null)
    //   //  {
    //   //    AlertDialog(
    //   //         title: const Text("Oops, something went wrong"),
    //   //         content: Text('$_response'),
    //   //         actions: [
    //   //           TextButton(
    //   //             onPressed: () => Navigator.of(context).pop(),
    //   //             child: const Text("OK"),
    //   //           ),
    //   //         ],
    //   //       );
    //   //  }
    //    final List<Map<String, dynamic>> userData = response;    
    //   final List<users> filteredusers = userData.where((user) => user['user_name'].toString().toLowerCase().contains(search_term.toString().toLowerCase()) ||
    //   user['user_email'].toString().toLowerCase().contains(search_term.toString().toLowerCase()) || user['user_designation'].toString().toLowerCase().contains(search_term.toString().toLowerCase())).map((user) => users.fromMap(); 
    
    // return filteredusers;
    // }
    return Row(
      children: [
        Container(
          width: 700,
          decoration: const BoxDecoration(color: whiteBG),
          child: Column(
            children: [
              const SearchField(),
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
                    Text(
                      "Users",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text("Projects",
                        style: TextStyle(fontSize: 25)),
                    // Text("Projects with Bugs", style: TextStyle(fontSize: 25))
                  ]),
              Expanded(
                child: TabBarView(controller: tabcontroller, children: [
                  //!Users screen
                  SizedBox(
                    child: GridView.builder(
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(16),
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
                                        images[index],
                                      ),
                                    ),
                                    title: const Text("username"),
                                    subtitle: const Text("use_designation"),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Team : team_name"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Project : project_name"),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  //Projects without Bugs screen
                  SizedBox(
                    child: GridView.builder(
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
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
                                        images[index],
                                      ),
                                    ),
                                    title: const Text("user_name"),
                                    //subtitle: const Text("team lead"),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Project : project_name"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("description : project_descriptiojn...."),
                                )
                              ],
                            ),
                          );
                        }),
                  ),

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
