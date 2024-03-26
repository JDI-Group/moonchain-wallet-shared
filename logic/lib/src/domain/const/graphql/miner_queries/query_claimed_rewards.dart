import 'package:mxc_logic/mxc_logic.dart';

String getClaimedRewardsQuery(String whereClause) => '''
    query get_claim_rewards {
      claimedRewards(where: { $whereClause }) {
        feeMXC
        mep1004TokenId
        valueMXC
        blockTimestamp
      }
    }
  ''';

String queryClaimedRewards(String type, List<String>? ids) {
  DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));

  final where = [
    if (ids != null) 'mep1004TokenId_in: [${ids.join(',')}]',
    if (type == 'week') 'blockTimestamp_gte: ${lastWeek.unix()}',
  ].join(',');

  final res = getClaimedRewardsQuery(where);
  return res;
}
