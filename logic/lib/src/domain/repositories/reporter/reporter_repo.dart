import 'dart:async';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:mxc_logic/src/domain/entities/reporter_info_response/reporter_info_response.dart';
import 'package:web3dart/web3dart.dart';

class ReporterRepository  {
  ReporterRepository (
    this._web3Client,
  ) : _restClient = RestClient();

  final Web3Client _web3Client;
  final RestClient _restClient;

  Future<String> getLastReportData() async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.reporterInfo,
      ),
    );

    final res =
        ReporterInfoResponse.fromJson(response.body);

    if (res.result?.lastReportData == null) {
      throw 'report_data_is_missing';
    }
    return res.result!.lastReportData!;
  }
}
