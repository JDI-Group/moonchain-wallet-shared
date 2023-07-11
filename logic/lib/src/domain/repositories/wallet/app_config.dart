import 'package:flutter/material.dart';
import 'package:mxc_logic/src/domain/entities/network_type.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static Map<NetworkType, AppConfigParams> networks =
      <NetworkType, AppConfigParams>{
    NetworkType.Wannsee: AppConfigParams(
      web3RpcHttpUrl: 'https://wannsee-rpc.mxc.com',
      web3WebSocketUrl: 'wss://wannsee-rpc.mxc.com',
      web3RpcWebsocketUrl: null,
      contractAddress: '',
      symbol: 'MXC',
      faucetUrl: 'about:blank',
      explorerUrl: 'https://wannsee-explorer.mxc.com',
      enabled: true,
      label: 'MXC Wannsee',
      chainId: 5167003,
    ),
    // NetworkType.Local: AppConfigParams(
    //   'http://192.168.40.197:8545',
    //   '0xD933a953f4786Eed5E58D234dFeadE15c96bAa8b',
    //   web3RpcWebsocketUrl: 'ws://192.168.40.197:8545',
    //   symbol: 'ETH',
    //   faucetUrl: 'about:blank',
    //   explorerUrl: 'about:blank',
    //   enabled: false,
    //   label: 'Local (Truffle)',
    // ),
    // If you are forking the project and will build on top of this boiler plate, please
    // create your onw nodes on infura.io or getblock.io
    // NetworkType.Ethereum: AppConfigParams(
    //   'https://eth.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/goerli/',
    //   '0x3B4c8de78c34773f5A1A656691734641f99066A1',
    //   web3RpcWebsocketUrl:
    //       'wss://eth.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/goerli/',
    //   symbol: 'ETH',
    //   faucetUrl: 'https://goerlifaucet.com',
    //   explorerUrl: 'https://goerli.etherscan.io',
    //   enabled: true,
    //   icon: Icons.currency_bitcoin,
    //   label: 'Ethereum (Goerli)',
    // ),
    // NetworkType.BSC: AppConfigParams(
    //   'https://bsc.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
    //   '0x73434bb95eC80d623359f6f9d7b84568407187BA',
    //   web3RpcWebsocketUrl:
    //       'wss://bsc.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
    //   symbol: 'BNB',
    //   faucetUrl: 'https://testnet.binance.org/faucet-smart',
    //   explorerUrl: 'https://testnet.bscscan.com',
    //   enabled: true,
    //   label: 'Binance Chain (BSC)',
    // ),
    // NetworkType.Matic: AppConfigParams(
    //   'https://matic.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
    //   '0x73434bb95eC80d623359f6f9d7b84568407187BA',
    //   web3RpcWebsocketUrl:
    //       'wss://matic.getblock.io/7188e622-0550-43e7-9124-d78e772c4994/testnet/',
    //   symbol: 'MATIC',
    //   faucetUrl: 'https://faucet.matic.network',
    //   explorerUrl: 'https://mumbai.polygonscan.com',
    //   enabled: true,
    //   label: 'Matic (Mumbai)',
    // )
  };
}

class AppConfigParams {
  AppConfigParams({
    required this.web3RpcHttpUrl,
    required this.contractAddress,
    required this.symbol,
    required this.faucetUrl,
    required this.enabled,
    required this.label,
    required this.explorerUrl,
    required this.web3RpcWebsocketUrl,
    required this.web3WebSocketUrl,
    required this.chainId,
    this.icon = Icons.attach_money,
  });
  final String? web3RpcWebsocketUrl;
  final String web3RpcHttpUrl;
  final String web3WebSocketUrl;
  final String contractAddress;
  final String symbol;
  final String faucetUrl;
  final IconData icon;
  final bool enabled;
  final String label;
  final String explorerUrl;
  final int chainId;
}
