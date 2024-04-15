import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';

class MXCFunctionHelpers {
  /// This function will have a return data for sure. If the api call doesn't succeed, handleFailure will return data.
  static Future<T> apiDataHandler<T>({
    required Future<Response> Function() apiCall,
    required T Function(String data) dataParseFunction,
    required Future<T> Function() handleFailure,
  }) async {
    final res = await apiCall();

    if (res.statusCode == 200) {
      return dataParseFunction(res.body);
    }
    return handleFailure();
  }

  static T mxcChainsSeparatedFunctions<T>({
    required int chainId,
    required T Function() mainnetFunc,
    required T Function() testnetFunc,
  }) {
    if (MXCChains.isMXCMainnet(chainId)) {
      return mainnetFunc();
    } else if (MXCChains.isMXCTestnet(chainId)) {
      return testnetFunc();
    } else {
      throw 'Unknown chain id given';
    }
  }

  static T chainsSeparatedFunctions<T>({
    required int chainId,
    required T Function() moonChainFunc,
    required T Function() genevaFunc,
    required T Function() ethereumFunc,
  }) {
    if (MXCChains.isMXCMainnet(chainId)) {
      return moonChainFunc();
    } else if (MXCChains.isMXCTestnet(chainId)) {
      return genevaFunc();
    } else if (MXCChains.isEthereumMainnet(chainId)) {
      return ethereumFunc();
    } else {
      throw 'Unknown chain id given';
    }
  }

  static Future<T?> mxcChainsFutureFuncWrapperNullable<T>(
    Future<T?> Function() func,
    int chainId, {
    Future<T>? notSupportChainData,
  }) async {
    if (MXCChains.isMXCChains(chainId)) {
      return await func();
    } else {
      return notSupportChainData;
    }
  }

  static T? mxcChainsFuncWrapperNullable<T>(
    T? Function() func,
    int chainId, {
    T? notSupportChainData,
  }) {
    if (MXCChains.isMXCChains(chainId)) {
      return func();
    } else {
      return notSupportChainData;
    }
  }

  static Future<T?> mxcAndEthereumFuncWrapperNullable<T>(
    Future<T?> Function() func,
    int chainId, {
    T? notSupportChainData,
  }) async {
    if (MXCChains.isMXCChains(chainId) ||
        MXCChains.isEthereumMainnet(chainId)) {
      return await func();
    } else {
      return notSupportChainData;
    }
  }
}
