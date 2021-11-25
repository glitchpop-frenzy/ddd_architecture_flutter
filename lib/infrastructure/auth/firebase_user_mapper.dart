import 'package:ddd_architecture_flutter/domain/auth/user.dart' as us;
import 'package:ddd_architecture_flutter/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserDomainX on User {
  us.User toDomain() {
    return us.User(id: UniqueID.fromUniqueString(uid));
  }
}
