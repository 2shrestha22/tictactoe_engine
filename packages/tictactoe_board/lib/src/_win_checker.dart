part of 'board.dart';

/// Returns winCombo in null no win if empty then it is draw.
Combo? _checkWin(int x, int y, Board board) {
  final mark = board.get(x, y);
  if (mark == null) return null;

  List<Box> combo = [];

  // check x th row for combo
  for (var n = 0; n < board.n; n++) {
    // itterate through all the elements in the column
    if (board.get(x, n) == mark) {
      combo.add(Box(mark: mark, x: x, y: n));
    } else if (combo.length >= board.winComboLength) {
      break;
    } else {
      combo.clear();
    }
  }
  if (combo.length >= board.winComboLength) {
    return combo;
  } else {
    combo.clear();
  }

  // check y th column for combo
  for (var n = 0; n < board.n; n++) {
    // itterate through all the elements in the column
    if (board.get(n, y) == mark) {
      combo.add(Box(mark: mark, x: n, y: y));
    } else if (combo.length >= board.winComboLength) {
      break;
    } else {
      combo.clear();
    }
  }
  if (combo.length >= board.winComboLength) {
    return combo;
  } else {
    combo.clear();
  }

  // Check diagonals for win. For board if size n and win combo < n, checking
  // diagonal is not sufficient. Sometimes super diagonals also needed to be
  // checked.

  // if sum is between (n -1) +/- (n-c) it is in diagonal (/)
  // sum = x+y. c = combo length
  if (x + y >= board.winComboLength - 1 &&
      x + y <= 2 * board.n - board.winComboLength - 1) {
    // check for diagonals

    // diagonal starts from (p,q) to (q,p)
    final q = (x + y) ~/ board.n;
    final p = x + y - q;
    for (var i = p; i >= q; i--) {
      if (board.get(i, x + y - i) == mark) {
        combo.add(Box(mark: mark, x: i, y: x + y - i));
      } else if (combo.length >= board.winComboLength) {
        break;
      } else {
        combo.clear();
      }
    }
    if (combo.length >= board.winComboLength) {
      return combo;
    } else {
      combo.clear();
    }
  }

  return null;
}
