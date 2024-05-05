import 'package:bahaso_mobile_app/data/sources/local/entities/entities.dart';

import '../../domain/models/models.dart';

extension AuthMapper on AuthEntity {
  Auth toModel() {
    return Auth(
      token: token ?? '',
      email: email ?? '',
    );
  }
}
