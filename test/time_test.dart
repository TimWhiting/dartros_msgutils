import 'package:dartros_msgutils/src/time_utils.dart';
import 'package:test/test.dart';

void main() {
  test('Time', () {
    final time1 = RosTime(secs: 0, nsecs: 0);
    final time2 = RosTime(secs: 0, nsecs: 1);

    expect(time1 <= time1, true);
    expect(time1 >= time1, true);
    expect(time1 == time1, true);

    expect(time1 < time2, true);
    expect(time1 <= time2, true);
    expect(time2 > time1, true);
    expect(time2 >= time1, true);

    final time3 = RosTime(secs: 0, nsecs: 0);
    final time4 = RosTime(secs: 1, nsecs: 0);
    expect(time3 < time4, true);
    expect(time4 > time3, true);

    expect(time4 > time2, true);

    final time5 = RosTime(secs: 2, nsecs: 0);
    final time6 = RosTime(secs: 2, nsecs: 1);
    expect(time5 < time6, true);
    expect(time6 > time5, true);

    final addition = time1 + time2 + time4 + time4;
    expect(addition, equals(time6));

    final time7 = RosTime(secs: 2, nsecs: 500000000);
    final time8 = RosTime(secs: 2, nsecs: 500000000);
    expect(time7 + time8, equals(RosTime(secs: 5)));

    expect(() => RosTime(secs: 0, nsecs: -1), throwsA(isA<AssertionError>()));
    expect(() => RosTime(secs: -1, nsecs: 0), throwsA(isA<AssertionError>()));
  });
}
