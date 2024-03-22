String getClaimTotalQuery(
  Map<String, String> queryKeys,
  String type,
  List<String> ids,
) =>
    '''
    query get_claim_total {
      ${queryKeys[type]}(where: { mep1004TokenId_in: ${ids.map((id) => '"$id"').join(',')} }) {
        mep1004TokenId
        rewardAmounts
        rewardTokens
        valueMXC
        feeMXC
        ${type == 'total' ? 'claimedDays' : ''}
      }
    }
  ''';

String queryClaimTotal(String type, List<String> ids) {
  final queryKeys = {
    'day': 'mep1004TokenRewardDayDatas',
    'month': 'mep1004TokenRewardMonthDatas',
    'week': 'mep1004TokenRewardWeekDatas',
    'year': 'mep1004TokenRewardYearDatas',
    'total': 'mep1004TokenRewardTotalDatas',
  };

  return getClaimTotalQuery(queryKeys, type, ids);
}
