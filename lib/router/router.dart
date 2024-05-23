import 'package:lessons/feature/crypto_coin/crypto_coin.dart';
import 'package:lessons/feature/crypto_list/crypto_list.dart';

final routes = {
  '/': (context) => const CryptoListScreen(),
  '/coin' : (context) => const CryptoCoinScreen()
};