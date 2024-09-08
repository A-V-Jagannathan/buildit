import 'dart:collection';

import 'package:buildit/Utils/Tuple.dart';

class Board {
  late int boardSize;
  late List<List<int>> board;
  late bool diagonalEnabled;

  Board(int n) {
    boardSize = n;
    board = List.generate(boardSize, (i) => List.generate(boardSize, (j) => 0));
    diagonalEnabled = false;
  }

  void setLand(int row, int column) {
    board[row][column] = 1;
  }

  void setWater(int row, int column) {
    board[row][column] = -1;
  }

  int islandCount() {
    List<List<int>> visited =
        List.generate(boardSize, (i) => List.generate(boardSize, (j) => 0));
    int count = 0;
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        if (visited[i][j] == 0 && board[i][j] == 1) {
          visited[i][j] = 1;
          bfs(i, j, visited);
          count++;
        }
      }
    }
    return count;
  }

  void bfs(int i, int j, List<List<int>> visited) {
    if (diagonalEnabled) {
      bfsDiagonal(i, j, visited);
    } else {
      bfsNormal(i, j, visited);
    }
  }

  void bfsDiagonal(int i, int j, List<List<int>> visited) {
    Queue<Tuple> queue = Queue<Tuple>();
    queue.add(Tuple(i, j));
    List<int> dx = [-1, 0, 1];
    int x = 0;
    int y = 0;
    while (queue.isNotEmpty) {
      Tuple element = queue.removeFirst();
      for (int i in dx) {
        for (int j in dx) {
          x = element.first + i;
          y = element.second + j;
          if (validateCell(x, y) && board[x][y] == 1) {
            visited[x][y] = 1;
            queue.add(Tuple(x, y));
          }
        }
      }
    }
  }

  void bfsNormal(int i, int j, List<List<int>> visited) {
    Queue<Tuple> queue = Queue<Tuple>();
    queue.add(Tuple(i, j));
    List<int> dx = [-1, 1];
    int x = 0;
    int y = 0;
    while (queue.isNotEmpty) {
      Tuple element = queue.removeFirst();
      for (int i in dx) {
        x = element.first;
        y = element.second + i;
        if (validateCell(x, y) && board[x][y] == 1) {
          visited[x][y] = 1;
          queue.add(Tuple(x, y));
        }
        x = element.first + i;
        y = element.second;
        if (validateCell(x, y) && board[x][y] == 1) {
          visited[x][y] = 1;
          queue.add(Tuple(x, y));
        }
      }
    }
  }

  bool validateCell(int i, int j) {
    if (i < boardSize && j < boardSize && i > -1 && j > -1) {
      return true;
    }
    return false;
  }
}
