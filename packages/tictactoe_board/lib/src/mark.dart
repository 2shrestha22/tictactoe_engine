enum Mark {
  zero,
  cross;

  /// Get complement Mark
  Mark get complement {
    switch (this) {
      case Mark.cross:
        return Mark.zero;
      case Mark.zero:
        return Mark.cross;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Mark.cross:
        return 'X';
      case Mark.zero:
        return 'O';
    }
  }
}
