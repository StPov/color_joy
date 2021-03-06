class LogicManager {
  static int _visibleSquaresCount = 0;
  static bool _isStarted = false;

  static void handleTap(bool isTapped) {
    _isStarted = true;
    _visibleSquaresCount =
        isTapped ? ++_visibleSquaresCount : --_visibleSquaresCount;
  }

  static bool checkIsAllSquaresHidden() {
    return (_isStarted && _visibleSquaresCount == 0);
  }
}
