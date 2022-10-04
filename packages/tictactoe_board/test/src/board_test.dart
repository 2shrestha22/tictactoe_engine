import 'package:test/test.dart';
import 'package:tictactoe_board/src/mark.dart';
import 'package:tictactoe_board/tictactoe_board.dart';

void main() {
  late Board board;

  setUp(() {
    board = Board(3, 3, 3);
  });

  test(
    'Column check for win is working.',
    () async {
      board.onComplete((Combo combo) {
        expect(
          combo,
          equals([
            Box(mark: Mark.zero, i: 0, j: 1),
            Box(mark: Mark.zero, i: 1, j: 1),
            Box(mark: Mark.zero, i: 2, j: 1),
          ]),
        );
      });

      for (var i = 0; i < 3; i++) {
        board.set(Mark.zero, i, 1);
      }
    },
  );
  test(
    'Row check for win is working.',
    () async {
      board.onComplete((Combo combo) {
        expect(
          combo,
          equals([
            Box(mark: Mark.zero, i: 1, j: 0),
            Box(mark: Mark.zero, i: 1, j: 1),
            Box(mark: Mark.zero, i: 1, j: 2),
          ]),
        );
      });

      for (var i = 0; i < 3; i++) {
        board.set(Mark.zero, 1, i);
      }
    },
  );
}
