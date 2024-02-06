import 'dart:async';
import 'dart:math';
import 'package:ens_dart/ens_dart.dart' as contracts;
import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:web3dart/web3dart.dart';

class PricingRepository {
  PricingRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

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
      final selectedNetwork = _web3Client.network!;
      final router = selectedNetwork.chainId == Config.mxcMainnetChainId
          ? Config.mainnetRouterAddress
          : selectedNetwork.chainId == Config.mxcTestnetChainId
              ? Config.testnetRouterAddress
              : null;
      if (router != null) {
        final routerAddress = EthereumAddress.fromHex(router);

        final routerContract = contracts.RouterContract(
          client: _web3Client,
          address: routerAddress,
        );
        final outputPrice = await routerContract.getAmountsOut(
          amountIn,
          [tokenA, tokenB],
        );
        final double amountOut = MxcAmount.convertWithTokenDecimal(
          outputPrice[1].toDouble(),
          tokenBDecimal,
        );
        return amountOut;
      } else {
        throw Exception('Router address is missing.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Token>> getTokensPrice(
    List<Token> tokens,
  ) async {
    try {
      if (!Config.isMxcChains(_web3Client.network!.chainId)) {
        return tokens;
      }
      final xsdToken = Config.mxcTestnetChainId == _web3Client.network!.chainId
          ? Config.xsdTestnet
          : Config.xsdMainnet;
      for (int i = 0; i < tokens.length; i++) {
        final currentToken = tokens[i];
        // The price of a token with 0 balance is zero
        if (currentToken.balance == 0.0) continue;
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
        } else {
          // Only the native token does not have address
          final wMxcToken =
              Config.mxcTestnetChainId == _web3Client.network!.chainId
                  ? Config.wMXCTestnet
                  : Config.wMXCMainnet;
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
