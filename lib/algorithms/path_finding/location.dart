class Location {
  final int _x;
  final int _y;

  Location(this._x, this._y);

  int get x => _x;
  int get y => _y;

  @override
  int get hashCode => _x.hashCode ^ _y.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Location && (_x == other.x && _y == other.y);
  }

  @override
  String toString() => "Location($_x, $_y)";
}