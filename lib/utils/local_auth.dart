import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    //status of authentication.
    bool isAuthenticated = false;

    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();

    List<BiometricType> biometricTypes =
        await _localAuthentication.getAvailableBiometrics();

    print(biometricTypes);

    //if device supports biometrics, then authenticate.
    if (isBiometricSupported) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: 'To continue, you must complete the biometrics',
            useErrorDialogs: true,
            stickyAuth: true);
      } on PlatformException catch (e) {
        print(e);
      }
    }

    return isAuthenticated;
  }
}

// class Authentication {
//   static Future<bool> authenticateWithBiometrics() async {
//     final LocalAuthentication localAuthentication = LocalAuthentication();
//     bool isBiometricSupported = await localAuthentication.isDeviceSupported();
//     bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

//     bool isAuthenticated = false;

//     if (isBiometricSupported && canCheckBiometrics) {
//       isAuthenticated = await localAuthentication.authenticate(
//         localizedReason: 'Please complete the biometrics to proceed.',
//         biometricOnly: true,
//         stickyAuth: true,
//       );
//     }

//     return isAuthenticated;
//   }
// }
