import 'dart:async';
import 'package:ens_dart/ens_dart.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:web3dart/web3dart.dart';

class TweetsRepository {
  TweetsRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final Web3Client _web3Client;
  final RestClient _restClient;

  Future<DefaultTweets> getDefaultTweets() async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.defaultTweets,
      ),
      headers: {'accept': 'application/json'},
    );

    final defaultTweets = DefaultTweets.fromJson(response.body);
    return defaultTweets;
  }
}
