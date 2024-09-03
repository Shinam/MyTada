import 'package:flutter_test/flutter_test.dart';
import 'package:tada_beta/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('FiltersViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
