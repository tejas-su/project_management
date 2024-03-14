// import 'dart:js_interop';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:project_management/models/projects_model.dart';
// import 'package:project_management/presentation/screens/imports.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SearchScreen extends StatefulWidget {
//   final SupabaseClient supabase;
//   const SearchScreen({super.key, required this.supabase});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     List<Future<dynamic>> list =[];

//     HelperFunctions helperFunctions = HelperFunctions();

//     //search term controller
//     TextEditingController searchTerm = TextEditingController();
//     String queryToFutureBuilder;
//     TabController tabcontroller = TabController(length: 1, vsync: this);
//     List images = [
//       "assets/avatars/man (1).png",
//       "assets/avatars/man (2).png",
//       "assets/avatars/man (3).png",
//       "assets/avatars/man (4).png",
//       "assets/avatars/man (5).png",
//     ];

   

//     return Row(
//       children: [
//         Container(
//           width: 700,
//           decoration: const BoxDecoration(color: whiteBG),
//           child: Column(
//             children: [
//               //search field implementation
//               Row(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: whiteContainer,
//                         ),
//                         child: Container(
//                           width: 500,
//                           child: TextField(
//                             controller: searchTerm,
//                             //  onChanged: (value) {
//                             //   search('users', search_term.text, context, widget.supabase);
//                             //  },  
//                             decoration: const InputDecoration(
//                               hintText: "Search",
//                               prefixIcon: Icon(Icons.search),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       )
//                       ),
                      
//                 ],
//               ),
//                Container(
//                         // width: 5,
//                         // height: 5,
//                          child: CTAButton(
                          
//                           text: 'search',
//                                               //  onTap: () => search(tabcontroller.toString(), search_term.toString(),context, widget.supabase)
//                                               onTap: (){
// setState(() {
//            queryToFutureBuilder=searchTerm.text;
//             print('updated query to search fn  :$queryToFutureBuilder');
//             list =helperFunctions.searchInProjectTable(tabcontroller.toString(),searchTerm.text,context,widget.supabase) as List<Future>;
//           });
//                                               } 
                                                
                                              
//                                                ),
//                        ),
//               TabBar(
//                   dividerColor: Colors.transparent,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   unselectedLabelColor: Colors.grey,
//                   labelColor: Colors.black,
//                   labelPadding: const EdgeInsets.symmetric(horizontal: 24),
//                   tabAlignment: TabAlignment.center,
//                   splashBorderRadius: BorderRadius.circular(16),
//                   indicator: BoxDecoration(
//                       color: whiteContainer,
//                       borderRadius: BorderRadius.circular(12)),
//                   controller: tabcontroller,
//                   tabs: const [
//                     // Text(
//                     //   "Users",
//                     //   style: TextStyle(fontSize: 25),
//                     // ),
//                     Text("projects", style: TextStyle(fontSize: 25)),
//                     // Text("Projects with Bugs", style: TextStyle(fontSize: 25))
//                   ]),
//               Expanded(
//                 child: TabBarView(controller: tabcontroller, children: [
//                   SizedBox(
//                             child: GridView.builder(
//                                 itemCount: list.length,
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                 ),
//                                 scrollDirection: Axis.vertical,
//                                 itemBuilder: (context, index) {
//                                   //List<Row> rows = snapshot.data as List<Row>;
//                                   //  for (Row row in rows) {
//                                   //   String TEAMNAE = row.children[index].toString();
//                                   //   print('Required team name from row $index is $TEAMNAE');
//                                   //  }
//                                   final searchdata = list[index];
//                                   return Container(
//                                     margin: const EdgeInsets.all(25),
//                                     color: whiteContainer,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 10.0, left: 4, bottom: 2),
//                                           child: ListTile(
//                                             leading: CircleAvatar(
//                                               radius: 30,
//                                               child: Image.asset(
//                                                 images[index],
//                                               ),
//                                             ), // Iterate through rows
                  
//                                             title: Text(
//                                                 "Team :${searchdata.} "),
//                                             //subtitle: const Text("team lead"),
//                                           ),
//                                         ),
//                                         const Padding(
//                                           padding: EdgeInsets.only(
//                                               top: 10.0, left: 25, bottom: 2),
//                                           child: Text("Project : "),
//                                         ),
//                                         const Padding(
//                                           padding: EdgeInsets.only(
//                                               top: 10.0, left: 25, bottom: 2),
//                                           child: Text("description :"),
//                                         )
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                           )
//                           ]
//               ))
//       ])
//       )]);
//   }
//     }