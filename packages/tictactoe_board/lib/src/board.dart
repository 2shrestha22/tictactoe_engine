import 'package:equatable/equatable.dart';
import 'mark.dart';
part '_win_checker.dart';

typedef Combo = List<Box>;

class Box extends Equatable {
  /// Represents squares in the tictactoe board.
  ///
  /// i is row of this box in the board.
  ///
  /// j is column of this box in the board.

  Box({required this.mark, required this.x, required this.y});

  final Mark? mark;

  /// Row of this box in the board.
  final int x;

  /// Column of this box in the board.
  final int y;

  /// Map index to one dimensional array (list)
  ///
  /// index of [xy] element of matrix of size [nxn].
  int index(int columns) => x * columns + y;

  @override
  String toString() => '[$x,$y - $mark]';

  @override
  List<Object?> get props => [mark, x, y];
}

class Board {
  /// Board of size [mxn].
  ///
  /// [n] is number of rows and columns - nxn.
  ///
  /// [value] is null when game is not finished. If combo is empty then game is
  /// draw. If [value] is non empty list then game is won.
  Board(this.n, this.winComboLength) {
    _initializeElements();
  }

  /// Sets elements to empty boxes.
  void _initializeElements() {
    _elements = List<Box>.generate(n * n, (index) {
      return Box(mark: null, x: index ~/ n, y: index % n);
    });
  }

  /// Number of columns
  final int n;

  final int winComboLength;

  late List<Box> _elements;

  List<Box> get elements => _elements;

  bool _completed = false;

  /// Get mark from ij th element.
  ///
  /// If j is null then i should be index in one dimensional array.
  Mark? get(int x, int y) => _elements[x * n + y].mark;

  /// Set mark on ij th element.
  ///
  /// Return List<Box> if game is finished else null.
  ///
  /// Will return empty list if game is over.
  ///
  /// Will throw [Exception] when game is already completed.
  Combo? set(Mark mark, int x, int y) {
    if (_completed) throw Exception('GAME_ALREADY_COMPLETED');

    _elements[x * n + y] = Box(mark: mark, x: x, y: y);

    final combo = _checkWin(x, y, this);

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
    for (var i = 0; i < n; i++) {
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
