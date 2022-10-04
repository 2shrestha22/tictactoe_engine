import 'package:test/test.dart';
import 'package:tictactoe_board/src/mark.dart';
import 'package:tictactoe_board/tictactoe_board.dart';

void main() {
  late Board board;
  Combo? combo;

  setUp(() {
    combo = null;
    board = Board(3, 3, 3);
    board.onComplete((Combo value) {
      combo = value;
    });
  });

  test(
    'Column check for win is working.',
    () async {
      for (var i = 0; i < 3; i++) {
        board.set(Mark.zero, i, 1);
      }
      expect(
        combo,
        equals([
          Box(mark: Mark.zero, i: 0, j: 1),
          Box(mark: Mark.zero, i: 1, j: 1),
          Box(mark: Mark.zero, i: 2, j: 1),
        ]),
      );
    },
  );
  test(
    'Row check for win is working.',
    () async {
      for (var i = 0; i < 3; i++) {
        board.set(Mark.zero, 1, i);
      }
      expect(
        combo,
        equals([
          Box(mark: Mark.zero, i: 1, j: 0),
          Box(mark: Mark.zero, i: 1, j: 1),
          Box(mark: Mark.zero, i: 1, j: 2),
        ]),
      );
    },
  );

  test(
    'Check diagonals for winCombo - /',
    () async {
      board.set(Mark.zero, 0, 0);
      board.set(Mark.cross, 1, 2);
      board.set(Mark.zero, 2, 2);
      board.set(Mark.cross, 2, 1);
      board.set(Mark.zero, 1, 1);

      expect(
        combo,
        equals([
          Box(mark: Mark.zero, i: 0, j: 0),
          Box(mark: Mark.zero, i: 1, j: 1),
          Box(mark: Mark.zero, i: 2, j: 2),
        ]),
      );
    },
  );
}
