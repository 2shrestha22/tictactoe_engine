import 'package:equatable/equatable.dart';
import 'mark.dart';

typedef Combo = List<Box>;

class Box extends Equatable {
  /// Represents squares in the tictactoe board.
  ///
  /// i is row of this box in the board.
  ///
  /// j is column of this box in the board.

  Box({required this.mark, required this.i, required this.j});

  final Mark? mark;

  /// Row of this box in the board.
  final int i;

  /// Column of this box in the board.
  final int j;

  /// Map index to one dimensional array (list)
  ///
  /// index of [ij] element of matrix of size [mn].
  ///
  /// [m] number of rows [columns] number of column
  int index(int columns) => i * columns + j;

  @override
  String toString() => '[$i,$j - $mark]';

  @override
  List<Object?> get props => [mark, i, j];
}

class Board {
  /// Board of size [mxn].
  ///
  /// [m] is number of rows and [n] is number of columns.
  ///
  /// [value] is null when game is not finished. If combo is empty then game is
  /// draw. If [value] is non empty list then game is won.
  Board(this.m, this.n, this.winComboLength) {
    _initializeElements();
  }

  /// Sets elements to empty boxes.
  void _initializeElements() {
    _elements = List<Box>.generate(m * n, (index) {
      return Box(mark: null, i: index ~/ n, j: index % n);
    });
  }

  /// Number of rows.
  final int m;

  /// Number of columns
  final int n;

  final int winComboLength;

  late List<Box> _elements;

  List<Box> get elements => _elements;

  bool _completed = false;

  /// Get mark from ij th element.
  ///
  /// If j is null then i should be index in one dimensional array.
  Mark? get(int i, int j) => _elements[i * n + j].mark;

  /// Set mark on ij th element.
  ///
  /// Return List<Box> if game is finished else null.
  ///
  /// Will return empty list if game is over.
  ///
  /// Will throw [Exception] when game is already completed.
  Combo? set(Mark mark, int i, int j) {
    if (_completed) throw Exception('GAME_ALREADY_COMPLETED');

    _elements[i * n + j] = Box(mark: mark, i: i, j: j);

    final combo = _checkWin(i, j, this);

    // invoke onFinished when game is finished i.e combo is not null
    if (combo != null) {
      _onFinishedCallback?.call(combo);
      _completed = true;
    }
    return combo;
  }

  /// Reset the board with initial state.
  void clear() {
    _completed = false;
    _initializeElements();
  }

  @override
  String toString() {
    String string = '';
    for (var i = 0; i < m; i++) {
      for (var j = 0; j < n; j++) {
        string = '$string${elements[i * n + j].mark} ';
      }
      string = '$string\n';
    }
    return string;
  }

  /// Will be called when game is completed.
  ///
  /// After game is completed user can clear the board.
  void onComplete(void Function(Combo combo) callback) {
    _onFinishedCallback = callback;
  }

  void Function(Combo combo)? _onFinishedCallback;
}

/// Returns winCombo in null no win if empty then it is draw.
Combo? _checkWin(int i, int j, Board board) {
  final mark = board.get(i, j);
  if (mark == null) return null;

  List<Box> combo = [];

  // check i th row for combo
  for (var n = 0; n < board.n; n++) {
    // itterate through all the elements in the column
    if (board.get(i, n) == mark) {
      combo.add(Box(mark: mark, i: i, j: n));
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

  // check j th column for combo
  for (var m = 0; m < board.m; m++) {
    // itterate through all the elements in the column
    if (board.get(m, j) == mark) {
      combo.add(Box(mark: mark, i: m, j: j));
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
  return null;
}
