import 'package:flutter_test/flutter_test.dart';
import 'package:mepco_meter_app/domain/seal_range.dart';

void main() {
  test('serial ranges are written like on the forms', () {
    final s = Serial.parse('TA-900009')!;
    expect(formatSerialRange(s, 4), 'TA-900009-10-11-12');
    expect(formatSerialRange(Serial.parse('TA-823623')!, 2), 'TA-823623-24');
    expect(formatSerialRange(s, 1), 'TA-900009');
    expect(Serial.parse('abc'), isNull);
  });

  test('fill spots in order (test data 3)', () {
    final m = fillSerials('TA-900001', {
      'TOU_MC': 1,
      'TOU_TC': 1,
      'MSB': 2,
      'MSB_2': 2,
      'MSB_GLASS': 2,
      'TFORMER': 4,
    });
    expect(m, {
      'TOU_MC': 'TA-900001',
      'TOU_TC': 'TA-900002',
      'MSB': 'TA-900003-04',
      'MSB_2': 'TA-900005-06',
      'MSB_GLASS': 'TA-900007-08',
      'TFORMER': 'TA-900009-10-11-12',
    });
  });

  test('first-last style: TA-823625-27', () {
    final s = Serial.parse('TA-823625')!;
    expect(formatSerialRange(s, 3, firstLast: true), 'TA-823625-27');
    expect(formatSerialRange(s, 1, firstLast: true), 'TA-823625');
    expect(fillSerials('TA-823621', {'TOU_MC': 1, 'MSB': 3}, firstLast: true), {
      'TOU_MC': 'TA-823621',
      'MSB': 'TA-823622-24',
    });
  });

  test('count of serials in a range', () {
    expect(serialCount('TA-823625-27'), 3);
    expect(serialCount('TA-823629-30-31-32'), 4);
    expect(serialCount('TA-823621'), 1);
    expect(serialCount('TA-823698-01'), 4);
    expect(serialCount(''), 0);
  });
}
