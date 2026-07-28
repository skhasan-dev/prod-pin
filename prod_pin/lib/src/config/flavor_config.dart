import 'package:prod_pin/bootstrap.dart' show Flavor;

class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    required String baseUrl,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor: flavor,
      baseUrl: baseUrl,
    );
    return _instance!;
  }

  FlavorConfig._internal({
    required this.flavor,
    required this.baseUrl,
  });

  final Flavor flavor;
  final String baseUrl;

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception(
        'FlavorConfig should be initialized in main before instance is retrieved',
      );
    }
    return _instance!;
  }

  static bool isStaging() => instance.flavor == Flavor.staging;

  static bool isProduction() => instance.flavor == Flavor.prod;
}
