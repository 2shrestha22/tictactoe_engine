import 'dart:math';

import 'package:tictactoe_board/tictactoe_board.dart';

class Ai {
  /// Return max possible value from the board.
  int minimax({
    /// Current state of board.
    required Board board,

    /// Whose move is it?
    /// let say AI (O) is always minimizing player. and human (X) is always
    /// maximizing player.
    required Mark player,
  }) {
    // it still have moves
    // final combo = board.checkWin(x, y);
    final List<Box> availableMoves =
        board.elements.where((e) => e.mark == null).toList();

    final winCombo = board.checkWin();

    if (winCombo != null) {
      if (winCombo.isNotEmpty) {
        /// game is completed
        if (winCombo.first.mark == Mark.cross) {
          // if maximizing player wins
          return 10;
        } else {
          // if minimizing player wins
          return -10;
        }
      } else {
        // game is over and noone won.
        return 0;
      }
    }

    if (player == Mark.cross) {
      // Cross is maximizing player

      int maxEval = -1000;
      for (var e in availableMoves) {
        final newBoard = board;
        final eval = minimax(
          board: newBoard..set(player, e.x, e.y),
          player: player.complement,
        );
        maxEval = max(eval, maxEval);
      }
      return maxEval;
    } else {
      // Zero is minimizing player
      int minEval = 1000;
      for (var e in availableMoves) {
        final newBoard = board;
        final eval = minimax(
          board: newBoard..set(player, e.x, e.y),
          player: player.complement,
        );
        minEval = min(eval, minEval);
      }
      return minEval;
    }
  }
}
