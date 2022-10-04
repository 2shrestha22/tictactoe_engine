import 'dart:developer';

import 'package:test/test.dart';
import 'package:tictactoe_board/src/mark.dart';
import 'package:tictactoe_board/tictactoe_board.dart';

void main() {
  late Board board;
  setUp(() {
    board = Board(3, 3, 3);
  });

  test(
    'Board is workign properly..',
    () async {
      for (var i = 0; i < 3; i++) {
        final combo = board.set(Mark.zero, i, 1);
        if (combo != null) {
          log(combo.toString());
        }
      }
      log(board.toString());
    },
  );
}
