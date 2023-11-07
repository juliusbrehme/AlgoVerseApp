import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.toPathFinding,
    required this.toSorting,
    required this.toTreeSearch,
  });

  final Function() toPathFinding;
  final Function() toSorting;
  final Function() toTreeSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _AlgorithmTile(
                  image: "lib/images/pathfinding.png",
                  description: "Pathfinding",
                  onTap: toPathFinding,
                ),
                _AlgorithmTile(
                  image: "lib/images/sorting.png",
                  description: "Sorting",
                  onTap: toSorting,
                ),
                _AlgorithmTile(
                  image: "lib/images/treesearch.png",
                  description: "Treesearch",
                  onTap: toTreeSearch,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AlgorithmTile extends StatelessWidget {
  const _AlgorithmTile({
    super.key,
    required this.image,
    required this.description,
    required this.onTap,
  });

  final String image;
  final String description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 300,
          child: Card(
            elevation: 10,
            color: const Color.fromRGBO(51, 74, 100, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 110,
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(image),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  description,
                  style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Outfit",
                      fontSize: 30),
                ),
                const Text(
                  "Visualization",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Outfit",
                      fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
