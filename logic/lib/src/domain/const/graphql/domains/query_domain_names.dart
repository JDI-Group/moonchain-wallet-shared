String queryDomainNames() {
  const res = '''

{
  domains(
    orderBy: createdAt, 
    orderDirection: desc, 
    where: {
      id_gt: 0, 
      name_not: null,
    }
  ) {
    id
    name
    wrappedDomain {
      owner {
        id
      }
      name
    }
  }
}
''';
  return res;
}
