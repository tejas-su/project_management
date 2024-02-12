import 'package:flutter/material.dart';
import 'package:project_management/presentation/components/searchField_section.dart';
import 'package:project_management/presentation/themes/themes.dart';

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
    return Row(
      children: [
        Container(
          width: 700,
          decoration: const BoxDecoration(color: whiteBG),
          child: Column(
            children: [
              const searchField(),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                //borderOnForeground: mounted,
                color: whiteBG,
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    automaticIndicatorColorAdjustment: true,
                    tabAlignment: TabAlignment.center,
                    //splashBorderRadius: BorderRadius.circular(100),
                    indicator: BoxDecoration(
                        color: whiteContainer,
                        borderRadius: BorderRadius.circular(16)),
                    controller: tabcontroller,
                    tabs: const [
                      Text(
                        "Users",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text("Project without Bugs",
                          style: TextStyle(fontSize: 25)),
                      Text("Projects with Bugs",
                          style: TextStyle(fontSize: 25))
                    ]),
              ),
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
                          return Card(
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
                                    title: const Text("Abhay B Prabhu"),
                                    subtitle: const Text("team lead"),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Team : Kraken"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Project : Lady_Bug"),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  //!Projects without Bugs screen
                  SizedBox(
                    child: GridView.builder(
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          //crossAxisSpacing: 25,
                          //mainAxisSpacing: 25,
                          //mainAxisExtent: 200
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Card(
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
                                    title: const Text("Abhay B Prabhu"),
                                    subtitle: const Text("team lead"),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Team : Kraken"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 25, bottom: 2),
                                  child: Text("Project : Lady_Bug"),
                                )
                              ],
                            ),
                          );
                        }),
                  ),

                  //!Projects with Bugs screen
                  SizedBox(
                    child: GridView.builder(
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: .9
                                //crossAxisSpacing: 25,
                                //mainAxisSpacing: 25,
                                //mainAxisExtent: 200
                                ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Expanded(
                            child: Card(
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
                                      title: const Text("Abhay B Prabhu"),
                                      subtitle: const Text("team lead"),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, left: 25, bottom: 1),
                                    child: Text("Team : Kraken"),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, left: 25, bottom: 1),
                                    child: Text("Project : Lady_Bug"),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.0,
                                      left: 25,
                                    ),
                                    child: Text("Bugs : 2"),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ),

        //!Description
        SizedBox(
          width: 700,
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteContainer,
              ),
              child: Column(children: [
                Card(
                  margin: EdgeInsets.all(25),
                  color: whiteContainer,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          
                          leading: CircleAvatar(
                            // maxRadius: 100,
                            
                        
                            // foregroundImage: AssetImage('assets/avatars/man (1).png'),
                           
                            
                           
                            child: Image.asset(
                              "assets/avatars/man (1).png",
                             
                              // fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            "Abhay B Prabhu",
                            style: TextStyle(fontSize: 25),
                          ),
                          subtitle: Text("team_lead"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Team : Kraken"),
                                Text("Project: Lady_Bug"),
                                Text("Bug : Error in Logics"),
                                Text("Bug Description:"),
                                Text(
                                    "Bug Description......Bug Description\nBug Description......Bug Description\nBug Description......Bug Description")
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ])),
        ))
      ],
    );
  }
}
