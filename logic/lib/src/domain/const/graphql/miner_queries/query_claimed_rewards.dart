import 'package:mxc_logic/mxc_logic.dart';

String getClaimedRewardsQuery(String where) => '''
    query get_claim_rewards {
      claimedRewards(where: { $where }) {
        feeMXC
        mep1004TokenId
        valueMXC
        blockTimestamp
      }
    }
  ''';

String queryClaimedRewards(String type, List<String> ids) {
  final where = [
    'mep1004TokenId_in: [${ids.map((id) => '"$id"').join(',')}]',
    if (type == 'week')
      'blockTimestamp_gte: ${DateTime.now().subtract(const Duration(days: 7)).unix()}',
  ].join(',');

  return getClaimedRewardsQuery(where);
}
