import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lessons/feature/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:lessons/feature/crypto_list/widgets/widgets.dart';
import 'package:lessons/repositories/crypto_coins/crypto_coins.dart';
import 'package:lessons/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());
  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto currencies'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      TalkerScreen(
                          talker: GetIt.I<Talker>()
                      ))
              );
          },
          icon: const Icon(Icons.document_scanner_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if(state is CryptoListLoaded){
              return ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  separatorBuilder: (context, i) => const Divider(),
                  itemCount: state.coinsList.length,
                  itemBuilder: (context, i) {
                    final coin = state.coinsList[i];
                    return CryptoCoinTile(coin: coin);
                  });
            }
            if(state is CryptoListLoadingFailure) {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Something went wrong!'),
                  const Text(
                    'Please try again later',
                  ),
                 const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      _cryptoListBloc.add(LoadCryptoList());
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      )
    );
  }
}

