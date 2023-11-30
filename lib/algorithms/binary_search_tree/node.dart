class Node {
  int value;
  Node? left;
  Node? right;
  Node? parent;
  double x = 0;
  int y = 0;
  double mod = 0;

  Node(this.value, [this.parent, this.left, this.right]);

  bool isLeaf() {
    return left == null && right == null;
  }

  bool isLeftChild() {
    Node? node = parent;
    if (node == null) {
      return true;
    } else {
      return node.left == this;
    }
  }

  int childrenCount() {
    if (left == null && right == null) {
      return 0;
    } else if (left == null && right != null || left != null && right == null) {
      return 1;
    } else {
      return 2;
    }
  }

  void visit(Map<Node, Node> map, Node node) {
    if (left != null) {
      left!.visit(map, this);
    }
    map[this] = node;

    if (right != null) {
      right!.visit(map, this);
    }
  }

  @override
  String toString() {
    return "$value";
  }
}
