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

class InfoResp{
  final String model;
  final String serial;
  final String regions;
  final String antennas;
  final String power_range;
  final String connected;
  final String status;

  InfoResp._({this.model, this.antennas, this.connected, this.power_range, this.regions, this.serial, this.status});

  factory InfoResp.fromJson(Map<String, dynamic> json){
    return new InfoResp._(
      antennas: json['antennas'],
      model: json['model'],
      serial: json['serial'],
      regions: json['regions'],
      power_range: json['power_range'],
      connected: json['connected'],
      status: json['status']
    );
  }
}
