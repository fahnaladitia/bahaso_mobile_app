class Auth {
  final String token;
  final String email;

  Auth({required this.token, required this.email});

  @override
  String toString() => 'Auth(token: $token, email: $email)';
}
