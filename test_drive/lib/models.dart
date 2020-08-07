class LoginResp{
  final String status;
  final String errors;
  final String token;

  LoginResp._({this.token, this.errors, this.status});

  factory LoginResp.fromJson(Map<String, dynamic> json) {
    return new LoginResp._(
      status: json['status'],
      errors: json['errors'],
      token: json['token'],
    );
  }
}
