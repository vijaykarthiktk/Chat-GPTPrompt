import 'package:chatgptprompt/screen/promptShow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../const/const.dart';
import '../searchdelegate/searchDelegate.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late PackageInfo packageInfo;
  List<String> promptsList = [];
  List<String> actsList = [];


  launchLink(String link) async {
    launchUrlString(link);
  }

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  onClicked(int index){
    print(prompts[index]['act']);
    Navigator.push(context, SwipeablePageRoute(
      builder: (context) => PromptScreen( act: prompts[index]["act"], prompt: prompts[index]["prompt"],),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: PromptSearch(actsList, promptsList));
              print(promptsList.length);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary
                ),
                accountName: Text("Chat-GPT Prompt"),
                accountEmail: null,
                currentAccountPicture:CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    child: Image.asset('assets/icons/icon.png'),
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.info),
              onTap: (){
                showAboutDialog(
                    context: context,
                    applicationIcon: Center(
                      child: CircleAvatar(
                        radius: 30,
                        child: ClipRRect(
                          child: Image.asset('assets/icons/icon.png'),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    applicationVersion: packageInfo.version,
                    children: [
                      const Text("Chat-GPT Prompt By VijayKarthik "),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: (){
                              launchLink(Github);
                            }, icon: const FaIcon(FontAwesomeIcons.github)),
                            IconButton(onPressed: (){
                              launchLink(Linkedin);
                            }, icon: const FaIcon(FontAwesomeIcons.linkedin)),
                            IconButton(onPressed: (){
                              launchLink(Twitter);
                            }, icon: const FaIcon(FontAwesomeIcons.twitter)),
                            IconButton(onPressed: (){
                              launchLink(Instagram);
                            }, icon: const FaIcon(FontAwesomeIcons.instagram))
                          ],
                        ),
                      )
                    ]
                );
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:  [
              Expanded (
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  addRepaintBoundaries: true,
                  itemCount: prompts.length,
                  itemBuilder: (context, index) {
                    if (!actsList.contains(prompts[index]['act'])) {
                      actsList.add(prompts[index]['act']);
                      promptsList.add(prompts[index]['prompt']);
                    }
                    return GestureDetector(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(prompts[index]['act']),
                            onTap: (){
                              onClicked(index);
                            },
                          ),
                          Divider(height: 1,)
                        ],
                      ),
                    );},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
