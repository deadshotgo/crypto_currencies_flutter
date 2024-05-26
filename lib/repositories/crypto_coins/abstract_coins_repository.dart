import 'models/models.dart';

abstract class AbstractCoinsRepository {
   Future<List<CryptoCoin>> getCoinsList();
   Future<CryptoCoinDetail> getCoinDetails(String currencyCode);
 }