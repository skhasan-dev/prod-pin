import 'package:prod_pin/bootstrap.dart' show Flavor;

String getApiConfig(Flavor flavor) {
  switch (flavor) {
    case Flavor.staging:
      return 'http://localhost:3000/api/';
    case Flavor.prod:
      return 'http://prod-pin.onrender.com/api/';
  }
}
