import 'package:ddd_architecture_flutter/domain/auth/user.dart';
import 'package:ddd_architecture_flutter/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart' as user;

extension FirebaseUserDomainX on user.User {
  User toDomain() {
    return User(id: UniqueID.fromUniqueString(uid));
  }
}
