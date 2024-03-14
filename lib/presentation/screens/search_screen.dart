import 'dart:math';
import 'package:flutter/material.dart';
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
  List<users> searchResults = [];

  TabController? tabcontroller;
  void search() async {
    var results = await HelperFunctions().searchInProjectTable(
        'users', searchTerm.text, context, widget.supabase) as List;
    setState(() {
      searchResults = results.cast<users>();
    });
  }

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    searchTerm.dispose();
    tabcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Circular avatar icon list
    List images = [
      "assets/avatars/man (1).png",
      "assets/avatars/man (2).png",
      "assets/avatars/man (3).png",
      "assets/avatars/man (4).png",
      "assets/avatars/man (5).png",
    ];

    return Row(children: [
      Container(
          width: 700,
          decoration: const BoxDecoration(color: whiteBG),
          child: Column(children: [
            //search field implementation
            Row(
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
                  Text("projects", style: TextStyle(fontSize: 25)),
                ]),

            Expanded(
                child: TabBarView(controller: tabcontroller, children: [
              if (searchResults.isNotEmpty)
                SizedBox(
                    child: GridView.builder(
                        itemCount: searchResults.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final searchdata = searchResults[0];

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
                                        images[Random().nextInt(5)],
                                      ),
                                    ), // Iterate through rows

                                    title: Text("Team: ${searchdata.name} "),
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
