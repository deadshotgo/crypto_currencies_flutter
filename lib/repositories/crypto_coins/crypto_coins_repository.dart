import 'package:dio/dio.dart';
import 'package:lessons/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required this.dio});


  @override
  Future<List<CryptoCoin>> getCoinsList() async {

    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,FIL,NOT,NEON,GOG,DOG,SEI,SUI,ZETA,WLD,BLD,SOL&tsyms=USD'
    );
     final data = response.data as Map<String, dynamic>;
     final dataRaw = data['RAW'] as Map<String, dynamic>;
     final cryptoCoinsList = dataRaw.entries.map((e) {
     final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
     final details  = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(
          name: e.key,
          details: details
      );
    }
    ).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details  = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(
      name: currencyCode,
      details: details
    );
  }
}