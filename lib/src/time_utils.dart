const NSEC_TO_SEC = 1e-9;
const USEC_TO_SEC = 1e-6;
const MSEC_TO_SEC = 1e-3;

class RosTime {
  const RosTime({this.secs = 0, this.nsecs = 0})
      : assert(secs >= 0, 'seconds must be > 0'),
        assert(nsecs >= 0, 'nanoseconds must be > 0');
  factory RosTime.epoch() => const RosTime();
  factory RosTime.now() => RosTime.fromDateTime(DateTime.now());
  factory RosTime.fromDateTime(DateTime dateTime) => RosTime(
      secs: (dateTime.millisecondsSinceEpoch * MSEC_TO_SEC).toInt(),
      nsecs: dateTime.microsecondsSinceEpoch % 1000000 * 1000);

  final int secs;
  final int nsecs;

  DateTime toDateTime() => DateTime.fromMillisecondsSinceEpoch(
      secs * 1000 + (nsecs * USEC_TO_SEC).floor());

  bool isZeroTime() => secs == 0 && nsecs == 0;

  int toSeconds() => secs + (nsecs * NSEC_TO_SEC).toInt();

  bool operator <(RosTime other) =>
      secs < other.secs || (secs == other.secs && nsecs < other.nsecs);

  bool operator <=(RosTime other) =>
      this < other || (secs == other.secs && nsecs == other.nsecs);

  bool operator >(RosTime other) =>
      secs > other.secs || (secs == other.secs && nsecs > other.nsecs);

  bool operator >=(RosTime other) =>
      this > other || (secs == other.secs && nsecs == other.nsecs);

  RosTime operator +(RosTime other) {
    final secs = this.secs + other.secs;
    final nsecs = this.nsecs + other.nsecs;
    const nsecsInSec = 1000000000;
    if (nsecs >= nsecsInSec) {
      return RosTime(
          secs: secs + nsecs ~/ nsecsInSec, nsecs: nsecs % nsecsInSec);
    }
    return RosTime(secs: secs, nsecs: nsecs);
  }

  bool operator ==(dynamic other) {
    return other is RosTime && other.secs == secs && other.nsecs == nsecs;
  }

  @override
  int get hashCode => Object.hash(secs, nsecs);

  @override
  String toString() {
    return 'secs: $secs, nsecs: $nsecs';
  }
}
