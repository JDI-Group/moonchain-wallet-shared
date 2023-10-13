enum NetworkType { testnet, mainnet, custom }

class Network {
  const Network({
    required this.logo,
    required this.web3RpcHttpUrl,
    required this.web3RpcWebsocketUrl,
    this.web3WebSocketUrl,
    required this.symbol,
    this.explorerUrl,
    required this.enabled,
    this.label,
    required this.chainId,
    required this.isAdded,
    required this.networkType,
  });

  final String logo;
  final String web3RpcHttpUrl;
  final String web3RpcWebsocketUrl;
  final String? web3WebSocketUrl;
  final String symbol;
  final String? explorerUrl;
  final bool enabled;
  final String? label;
  final int chainId;
  final bool isAdded;
  final NetworkType networkType;

  Network copyWith(
      {String? logo,
      String? web3RpcHttpUrl,
      String? web3RpcWebsocketUrl,
      String? web3WebSocketUrl,
      String? symbol,
      String? explorerUrl,
      bool? enabled,
      String? label,
      int? chainId,
      bool? isAdded,
      NetworkType? networkType}) {
    return Network(
        logo: logo ?? this.logo,
        web3RpcHttpUrl: web3RpcHttpUrl ?? this.web3RpcHttpUrl,
        web3RpcWebsocketUrl: web3RpcWebsocketUrl ?? this.web3RpcWebsocketUrl,
        web3WebSocketUrl: web3WebSocketUrl ?? this.web3WebSocketUrl,
        symbol: symbol ?? this.symbol,
        explorerUrl: explorerUrl ?? this.explorerUrl,
        enabled: enabled ?? this.enabled,
        label: label ?? this.label,
        chainId: chainId ?? this.chainId,
        isAdded: isAdded ?? this.isAdded,
        networkType: networkType ?? this.networkType);
  }

  Network copyWithOther(Network otherNetwork) {
    return Network(
        logo: otherNetwork.logo,
        web3RpcHttpUrl: otherNetwork.web3RpcHttpUrl,
        web3RpcWebsocketUrl: otherNetwork.web3RpcWebsocketUrl,
        web3WebSocketUrl: otherNetwork.web3WebSocketUrl ?? web3WebSocketUrl,
        symbol: otherNetwork.symbol,
        explorerUrl: otherNetwork.explorerUrl ?? explorerUrl,
        enabled: enabled,
        label: otherNetwork.label ?? label,
        chainId: otherNetwork.chainId,
        isAdded: isAdded,
        networkType: otherNetwork.networkType);
  }

  /// True means they are same.
  bool compareWithOther(Network otherNetwork) {
    return logo == otherNetwork.logo &&
        web3RpcHttpUrl == otherNetwork.web3RpcHttpUrl &&
        web3RpcWebsocketUrl == otherNetwork.web3RpcWebsocketUrl &&
        web3WebSocketUrl == otherNetwork.web3WebSocketUrl &&
        symbol == otherNetwork.symbol &&
        explorerUrl == otherNetwork.explorerUrl &&
        label == otherNetwork.label &&
        chainId == otherNetwork.chainId &&
        networkType == otherNetwork.networkType;
  }

  // This data will be initialized for the first time
  // the first two are always mxc chains
  static List<Network> fixedNetworks() {
    return [
      const Network(
        logo: 'assets/svg/networks/mxc.svg',
        web3RpcHttpUrl: 'https://wannsee-rpc.mxc.com',
        web3RpcWebsocketUrl: 'wss://wannsee-rpc.mxc.com',
        web3WebSocketUrl:
            'wss://wannsee-explorer-v1.mxc.com/socket/v2/websocket?vsn=2.0.0',
        symbol: 'MXC',
        explorerUrl: 'https://wannsee-explorer.mxc.com',
        enabled: false,
        label: 'MXC Wannsee Testnet',
        chainId: 5167003,
        isAdded: true,
        networkType: NetworkType.testnet,
      ),
      const Network(
        logo: 'assets/svg/networks/mxc.svg',
        web3RpcHttpUrl: 'https://rpc.mxc.com',
        web3RpcWebsocketUrl: 'wss://rpc.mxc.com',
        web3WebSocketUrl:
            'wss://explorer-v1.mxc.com/socket/v2/websocket?vsn=2.0.0',
        symbol: 'MXC',
        explorerUrl: 'https://explorer.mxc.com/',
        enabled: true,
        label: 'MXC zkEVM Mainnet',
        chainId: 18686,
        isAdded: true,
        networkType: NetworkType.mainnet,
      ),
      const Network(
        logo: 'assets/svg/networks/ethereum.svg',
        web3RpcHttpUrl: 'https://ethereum.publicnode.com',
        web3RpcWebsocketUrl: 'wss://ethereum.publicnode.com',
        symbol: 'ETH',
        explorerUrl: 'https://etherscan.io/',
        enabled: false,
        label: 'Ethereum Mainnet',
        chainId: 1,
        isAdded: true,
        networkType: NetworkType.mainnet,
      ),
      const Network(
        logo: 'assets/svg/networks/arbitrum.svg',
        web3RpcHttpUrl: 'https://arbitrum.blockpi.network/v1/rpc/public',
        web3RpcWebsocketUrl: 'wss://arbitrum.blockpi.network/v1/rpc/public',
        symbol: 'Eth',
        explorerUrl: 'https://arbiscan.io/',
        enabled: false,
        label: 'Arbitrum One',
        chainId: 42161,
        isAdded: true,
        networkType: NetworkType.mainnet,
      ),
      const Network(
        logo: 'assets/svg/networks/arbitrum.svg',
        web3RpcHttpUrl: 'https://arbitrum-goerli.publicnode.com',
        web3RpcWebsocketUrl: 'wss://arbitrum-goerli.publicnode.com',
        symbol: 'AGOR',
        explorerUrl: 'https://goerli-rollup-explorer.arbitrum.io/',
        enabled: false,
        label: 'Arbitrum Goerli',
        chainId: 421613,
        isAdded: false,
        networkType: NetworkType.testnet,
      ),
      const Network(
        logo: 'assets/svg/networks/ethereum.svg',
        web3RpcHttpUrl: 'https://eth-sepolia.public.blastapi.io',
        web3RpcWebsocketUrl: 'wss://eth-sepolia.public.blastapi.io',
        symbol: 'ETH',
        explorerUrl: 'https://sepolia.etherscan.io/',
        enabled: false,
        label: 'Sepolia Testnet',
        chainId: 11155111,
        isAdded: false,
        networkType: NetworkType.testnet,
      )
    ];
  }
}
