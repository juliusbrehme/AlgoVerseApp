class PseudoCode {
  static String Astar() {
    return """
Initialize an open list (priority queue) and add the start node to it.
Initialize a closed list (set) to keep track of visited nodes.
Loop:
    if the open list is empty:
        Path not found. 
        return failure.
    Else:
        Remove the node with the lowest 
        f(x) = g(x) + h(x) from the open 
        list, where g(x) is the cost from 
        the start node to the current node, 
        and h(x) is the heuristic estimated 
        cost from the current node to the target.
        if the removed node is the target, 
        reconstruct and return the path.
        Mark the node as visited by adding it 
        to the closed list.
        For each neighbor of the current node:
            if the neighbor is in the closed list, 
            skip it.
            Calculate g(x) for the neighbor.
            if the neighbor is not in the open list 
            or the new g(x) is lower:
                Update the neighbors g(x), h(x), 
                and f(x).
                Set the current node as the parent 
                of the neighbor.
                Add the neighbor to the open list 
                if it is not already present.
return failure if no path is found.
""";
  }

  static String DFS() {
    return """
Start by putting any one of the graphs 
vertices on top of a stack.
Loop:
    if the stack is empty:
        return or end the function.
    Else:
        Pop a vertex from the stack to 
        select the next vertex to visit.
        if the vertex is not marked as 
        discovered:
            Mark it as discovered.
            Add it to the visited list.
            Push all adjacent vertices 
            (that are not marked as discovered) 
            to the stack.
return the visited list as the result of DFS traversal.
""";
  }

  static String Dijkstra() {
    return """
Initialize Distances and Set Unvisited Nodes:
    for(vertex v in Graph):
        distance[v] = infinity
        distance[source] = 0
    unvisited = set(all vertices)
while(Processing Each Node):
    while(unvisited != null):
        current_vertex = vertex in unvisited 
        with min distance
        Update Distances for Neighbors:
            for each neighbor n of current_vertex:
                new_dist = 
                  distance[current_vertex] + 
                  edge_weight(current_vertex, n)
                if(new_dist < distance[n]):
                    distance[n] = new_dist
        unvisited.remove(current_vertex)
        Check if Finished:
            if(destination in visited or 
            min distance in unvisited is infinity):
                break
return Shortest Path:
    return distance[destination]
""";
  }

  static String BFS() {
    return """
let Q be a queue
label root as explored
Q.enqueue(root)
while Q is not empty do
    v := Q.dequeue()
    if v is the goal then
        return v
    for all edges from v to w in G.adjacentEdges(v) do
        if w is not labeled as explored then
            label w as explored
            w.parent := v
            Q.enqueue(w)
""";
  }

  static String BubbleSort() {
    return """
list of numbers
for all elements of list
  if list[i] > list[i+1]
      swap(list[i], list[i+1])
return list
""";
  }

  static String InsertionSort() {
    return """
list of numbers
i = 0
while i < length(list)
    j = i
    while j > 0 and list[j-1] > list[j]
        swap A[j] and A[j-1]
        j = j - 1
    i = i + 1
return list
""";
  }

  static String MergeSort() {
    return """
MergeSort(A, p, r):
  if p > r 
      return
  q = (p+r)/2
  mergeSort(A, p, q)
  mergeSort(A, q+1, r)
  merge(A, p, q, r)

merge(A, p, q, r):
  Have we reached the end of any of the 
  arrays?
    No:
        Compare current elements of 
        both arrays 
        Copy smaller element into 
        sorted array
        Move pointer of element 
        containing smaller element
    Yes:
        Copy all remaining elements 
        of non-empty array
""";
  }

  static String QuickSort() {
    return """
function quickSort(arr, l, r)
  if l < r
      pivotIndex = partition(arr, l, r)
      quickSort(arr, l, pivotIndex - 1)
      quickSort(arr, pivotIndex + 1, r)

function partition(arr, l, r)
  pivot = arr[r]
  i = l - 1
  
  for j = l to r - 1
      if arr[j] < pivot
          i = i + 1
          swap arr[i] and arr[j]
  
  swap arr[i + 1] and arr[r]
  return i + 1
""";
  }

  static String SelectionSort() {
    return """
for i from 0 to length of array - 1:
    Find the index of the smallest element 
    in the subarray starting from i:
        min_index = i
        for j from i + 1 to length of array - 1:
            if array[j] < array[min_index] then:
                min_index = j
    Swap the smallest element with the 
    first unsorted element:
        temp = array[i]
        array[i] = array[min_index]
        array[min_index] = temp
return array
""";
  }

  static String SearchBinarySearchTree() {
    return """
search (node, value):
  if node is null:
      return null
  if node.val is equal to lookfor:
      return node
  if node.val is less than lookfor
      return findval (node.right, value)
  return findval (node.left, value)
""";
  }
}
