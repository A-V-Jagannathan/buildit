import 'package:buildit/PlayArea/Board.dart';

class PlayScreen {
  late int landCount, waterCount, cellCount;
  late Board board;
  bool landPlace = true;
  PlayScreen(int landC, int waterC, int n) {
    landCount = landC;
    waterCount = waterC;
    board = Board(n);
    cellCount = n * n;
  }

  void play() {
    int place = 0;
    while (cellCount > 0) {
      if (landPlace) {
        place = landCount;
        while (place > 0 && cellCount > 0) {
          //Place a land
          place--;
          cellCount--;
        }
        landPlace = false;
      } else {
        place = waterCount;
        while (place > 0 && cellCount > 0) {
          //Place a water
          place--;
          cellCount--;
        }
        landPlace = true;
      }
    }
  }
}
