import 'package:algo_verse_app/components/buttons/find_path_button.dart';
import 'package:algo_verse_app/components/buttons/search_tree_button.dart';
import 'package:algo_verse_app/components/buttons/sorting_button.dart';
import 'package:algo_verse_app/components/buttons/highlighted_option_button.dart';
import 'package:algo_verse_app/components/buttons/home_button.dart';
import 'package:algo_verse_app/components/buttons/option_button.dart';
import 'package:algo_verse_app/pages/main_page.dart';
import 'package:algo_verse_app/pages/pathfinding.dart';
import 'package:algo_verse_app/pages/sorting.dart';
import 'package:algo_verse_app/pages/treesearch.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // index to show the right page
  int _selectedPage = 0;

  // the different expandable visualizer button, SizeBox to show nothing on the main page
  final List<Widget> _fab = const [
    SizedBox(),
    FindPathButton(),
    SortingButton(),
    SearchTreeButton(),
  ];

  Widget getPage(int selectedPage) {
    switch (selectedPage) {
      case 0:
        return MainPage(
          toPathFinding: toPathFinding,
          toSorting: toSorting,
          toTreeSearch: toTreeSearch,
        );
      case 1:
        return PathFindingPage();
      case 2:
        return SortingPage();
      default:
        return TreeSearchPage();
    }
  }

  void toPathFinding() {
    setState(() {
      _selectedPage = 1;
    });
  }

  void toSorting() {
    setState(() {
      _selectedPage = 2;
    });
  }

  void toTreeSearch() {
    setState(() {
      _selectedPage = 3;
    });
  }

  bool highlightPath() {
    if (_selectedPage == 1) {
      return true;
    }
    return false;
  }

  bool highlightSorting() {
    if (_selectedPage == 2) {
      return true;
    }
    return false;
  }

  bool highlightTreeSearch() {
    if (_selectedPage == 3) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(51, 74, 100, 1),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.sync,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              onPressed: () {
                print("Switch");
              },
            ),
          )
        ],
        //toolbarHeight: 70,
      ),
      // Hier wird mit Index ausgewählt welche Drawer gezeigt wird, daher drawer alle extra in klasse machen
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(51, 74, 100, 1),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            HomeButton(
              onTap: () {
                setState(() {
                  _selectedPage = 0;
                });
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // if (true == 0) ...[const Text("Well")], damit kann man dann einen drawer erstellen!
            highlightPath()
                ? HighlightedOptionButton(
                    image: "lib/images/pathfinding.png",
                    description: "Pathfinding Algorithm",
                    onTap: () {
                      setState(() {
                        _selectedPage = 1;
                      });
                      Navigator.pop(context);
                    },
                  )
                : OptionButton(
                    image: "lib/images/pathfinding.png",
                    description: "Pathfinding Algorithm",
                    onTap: () {
                      setState(() {
                        _selectedPage = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
            highlightSorting()
                ? HighlightedOptionButton(
                    image: "lib/images/sorting.png",
                    description: "Sorting Algorithm",
                    onTap: () {
                      setState(() {
                        _selectedPage = 2;
                      });
                      Navigator.pop(context);
                    },
                  )
                : OptionButton(
                    image: "lib/images/sorting.png",
                    description: "Sorting Algorithm",
                    onTap: () {
                      setState(() {
                        _selectedPage = 2;
                      });
                      Navigator.pop(context);
                    },
                  ),
            highlightTreeSearch()
                ? HighlightedOptionButton(
                    image: "lib/images/treesearch.png",
                    description: "Tree Search Algorithm",
                    onTap: () {
                      setState(() {
                        _selectedPage = 3;
                      });
                      Navigator.pop(context);
                    },
                  )
                : OptionButton(
                    image: "lib/images/treesearch.png",
                    description: "Tree Search Algorithm",
                    onTap: () {
                      setState(() {
                        _selectedPage = 3;
                      });
                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
      ),
      body: getPage(_selectedPage),
      //_pages[_selectedPage],
      floatingActionButton: _fab[_selectedPage],
      backgroundColor: const Color.fromARGB(255, 79, 115, 156),
    );
  }
}

// color for main pages: #496a8e
