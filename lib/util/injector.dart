import 'package:mvp_app/repository/contact_repository.dart';

enum Flavor {
  MOCK,
  PRO
}

class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  ContactRepository get contactRepository {
    switch(_flavor) {
      case Flavor.MOCK: return MockContactRepository();
      default: return RandomUserRepository();
    }
  }
}