import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pettygram_flutter/data/core/network_info.dart';

class MockConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late MockConnectionChecker mockConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockConnectionChecker = MockConnectionChecker();
    networkInfo = NetworkInfoImpl(mockConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      final tHasConnectionFuture = Future.value(true);

      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((invocation) => tHasConnectionFuture);

      final result = networkInfo.isConnected;
      verify(() => mockConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
