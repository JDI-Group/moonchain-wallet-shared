import 'dart:async';
import 'dart:math';
import 'package:ens_dart/ens_dart.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:web3dart/web3dart.dart';

class PricingRepository {
  PricingRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;

  Future<double> getAmountsOut(
    double amount,
    Token token0,
    Token token1,
  ) async {
    try {
      final tokenA = EthereumAddress.fromHex(token0.address!);
      final tokenADecimal = token0.decimals!;
      final tokenB = EthereumAddress.fromHex(token1.address!);
      final tokenBDecimal = token1.decimals!;
      final amountIn = BigInt.from(amount * (pow(10, tokenADecimal)));
      final routerAddress = EthereumAddress.fromHex(Const.routerAddress);

      final routerContract =
          RouterContract(client: _web3Client, address: routerAddress);
      final outputPrice = await routerContract.getAmountsOut(
        amountIn,
        [tokenA, tokenB],
      );
      final double amountOut = MxcAmount.convertWithTokenDecimal(
        outputPrice[1].toDouble(),
        tokenBDecimal,
      );
      return amountOut;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Token>> getTokensPrice(
    List<Token> tokens,
  ) async {
    try {
      final xsdToken = tokens.firstWhere((element) => element.symbol == 'XSD');
      for (int i = 0; i < tokens.length; i++) {
        final currentToken = tokens[i];
        if (currentToken.address != null) {
          try {
            final balancePrice = await getAmountsOut(
              currentToken.balance!,
              currentToken,
              xsdToken,
            );
            tokens[i] = currentToken.copyWith(balancePrice: balancePrice);
          } catch (e) {
            continue;
          }
        } else if (currentToken.symbol == 'MXC') {
          final wMxcToken =
              tokens.firstWhere((element) => element.symbol == 'WMXC');
          try {
            final balancePrice = await getAmountsOut(
              currentToken.balance!,
              currentToken.copyWith(address: wMxcToken.address, decimals: 0),
              xsdToken.copyWith(decimals: 0),
            );
            tokens[i] = currentToken.copyWith(balancePrice: balancePrice);
          } catch (e) {
            continue;
          }
        }
      }
      return tokens;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
