import 'package:mxc_logic/mxc_logic.dart';

Map<String, String> mep1004TokenRewardKeys = {
  'day': 'mep1004TokenRewardDayDatas',
  'month': 'mep1004TokenRewardMonthDatas',
  'week': 'mep1004TokenRewardWeekDatas',
  'year': 'mep1004TokenRewardYearDatas',
  'total': 'mep1004TokenRewardTotalDatas',
};

String getClaimTotalQuery(
  Map<String, int> times,
  Map<String, String> queryKeys,
  String type,
  String whereClause,
) =>
    '''
    query get_claim_total {
      ${queryKeys[type]}(where: { $whereClause }) {
        mep1004TokenId
        rewardAmounts
        rewardTokens
        valueMXC
        feeMXC
        ${type == 'total' ? 'claimedDays' : ''}
      }
    }
  ''';

String queryClaimTotal(String type, List<String>? ids) {
  DateTime now = DateTime.now();
  int timestamp = now.unix();

  Map<String, int> times = {
    'day': timestamp ~/ 86400,
    'week': timestamp ~/ 604800,
    'month': timestamp ~/ 2592000,
    'year': timestamp ~/ 31536000,
    // 'total': 0,
  };

  String where = [
    if (ids != null) 'mep1004TokenId_in: [${ids.join(',')}]',
    if (times[type] != null) 'dateID: ${times[type]}',
  ].join(',');

  final res = getClaimTotalQuery(
    times,
    mep1004TokenRewardKeys,
    type,
    where,
  );
  return res;
}
