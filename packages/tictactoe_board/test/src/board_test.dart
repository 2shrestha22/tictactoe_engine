import 'package:test/test.dart';
import 'package:tictactoe_board/tictactoe_board.dart';

void main() {
  late Board board;
  Combo? combo;

  setUp(() {
    combo = null;
    board = Board(4, 3);
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
          Box(mark: Mark.zero, x: 0, y: 1),
          Box(mark: Mark.zero, x: 1, y: 1),
          Box(mark: Mark.zero, x: 2, y: 1),
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
          Box(mark: Mark.zero, x: 1, y: 0),
          Box(mark: Mark.zero, x: 1, y: 1),
          Box(mark: Mark.zero, x: 1, y: 2),
        ]),
      );
    },
  );

  test(
    'Check anti diagonals for winCombo - /',
    () async {
      board.set(Mark.zero, 0, 2);
      board.set(Mark.cross, 1, 2);
      board.set(Mark.zero, 2, 0);
      board.set(Mark.cross, 2, 1);
      board.set(Mark.zero, 1, 1);

      expect(
        combo,
        unorderedEquals([
          Box(mark: Mark.zero, x: 2, y: 0),
          Box(mark: Mark.zero, x: 1, y: 1),
          Box(mark: Mark.zero, x: 0, y: 2),
        ]),
      );
    },
  );

  test(
    'Check diagonals for winCombo',
    () async {
      board.set(Mark.zero, 1, 0);
      board.set(Mark.cross, 1, 2);
      board.set(Mark.zero, 3, 2);
      board.set(Mark.cross, 2, 2);
      board.set(Mark.zero, 2, 1);

      expect(
        combo,
        unorderedEquals([
          Box(mark: Mark.zero, x: 1, y: 0),
          Box(mark: Mark.zero, x: 2, y: 1),
          Box(mark: Mark.zero, x: 3, y: 2),
        ]),
      );
    },
  );
}
