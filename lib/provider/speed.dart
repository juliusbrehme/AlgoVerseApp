enum Speed {
  fast,
  slow;

  @override
  String toString() {
    String toCapitalize = name;
    return "${toCapitalize[0].toUpperCase()}${toCapitalize.substring(1)}";
  }
}
