///this class contains all the math for analysing our results to return more human readable data
///
///TODO: Set up this as a provider
class ResultMath {
  final double turnRatio;
  final double roundnessRatio;
  final double closenessRatio;
  final double dxOuterLeft;
  final double dyOuterLeft;
  final double faceHeight;
  String _hooded;

  String get hooded => _hooded;

  set hooded(String hooded) {
    _hooded = hooded;
  }

  ResultMath(
      {this.dxOuterLeft,
      this.dyOuterLeft,
      this.faceHeight,
      this.turnRatio,
      this.roundnessRatio,
      this.closenessRatio});

  int getTurnPercentage() {
    return _percentageFromRange(value: turnRatio, min: -1, max: 4);
  }

  int getRoundnessPercentage() {
    return _percentageFromRange(value: roundnessRatio, min: 0, max: 8);
  }

  int getClosenessPercentage() {
    return _percentageFromRange(value: closenessRatio, min: 50, max: 105);
  }

  int _percentageFromRange({double min, double max, double value}) {
    return (((value - min) * 100) ~/ (max - min));
  }

  String getEyeTurnText() {
    int percentage = getTurnPercentage();
    if (percentage <= 30) {
      return 'Downturned';
    }
    if (percentage <= 35 && percentage >= 30) {
      return 'Slightly Downturned';
    }
    if (percentage >= 35 && percentage <= 45) {
      return 'Not Turned';
    }
    if (percentage >= 45 && percentage <= 50) {
      return 'Slightly Upturned';
    }
    if (percentage > 50) {
      return 'Upturned';
    }
    return '';
  }

  String getEyeRoundnessText() {
    int percentage = getRoundnessPercentage();
    if (percentage <= 35) {
      return 'Round';
    }
    if (percentage <= 40 && percentage >= 35) {
      return 'Slightly Round';
    }
    if (percentage >= 40 && percentage <= 50) {
      return 'Average';
    }
    if (percentage >= 50 && percentage <= 55) {
      return 'Slightly Almond';
    }
    if (percentage > 55) {
      return 'Almond';
    }
    return '';
  }

  String getEyeClosenessText() {
    int percentage = getClosenessPercentage();
    if (percentage <= 40) {
      return 'Wide Set';
    }
    if (percentage <= 45 && percentage >= 40) {
      return 'Slightly Wide Set';
    }
    if (percentage >= 45 && percentage <= 55) {
      return 'Average';
    }
    if (percentage >= 55 && percentage <= 60) {
      return 'Slightly Close Set';
    }
    if (percentage > 60) {
      return 'Close Set';
    }
    return '';
  }
}
