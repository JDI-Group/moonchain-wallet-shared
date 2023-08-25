// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnsAddresses {
  EnsAddresses({
    required this.ens,
    required this.ensFallbackRegistry,
    required this.ensResolver,
    required this.ensReverseResolver,
    required this.ensReverseRegistrar,
  });

  String ens;
  String ensFallbackRegistry;
  String ensResolver;
  String ensReverseResolver;
  String ensReverseRegistrar;
}
