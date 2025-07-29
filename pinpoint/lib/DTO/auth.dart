class AuthRequest {
  String? email;
  String? phone;
  String? password;
  String? role;
  String? jwt;
  String? statusCode;
  String? error;
  String? message;

  AuthRequest({
    this.email,
    this.phone,
    this.password,
    this.role,
    this.jwt,
    this.statusCode,
    this.error,
    this.message,
  });

  /// Named constructor for login
  AuthRequest.forLogin({this.email, this.phone, this.password});

  /// Named constructor for registration
  AuthRequest.forRegister({this.email, this.phone, this.password, this.role});

  /// Named constructor for JWT-based auth response
  AuthRequest.fromJwt({this.jwt, this.statusCode, this.error, this.message});

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      jwt: json['jwt'],
      statusCode: json['statusCode'],
      error: json['error'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (role != null) data['role'] = role;
    if (jwt != null) data['jwt'] = jwt;
    if (statusCode != null) data['statusCode'] = statusCode;
    if (error != null) data['error'] = error;
    if (message != null) data['message'] = message;
    return data;
  }
}
