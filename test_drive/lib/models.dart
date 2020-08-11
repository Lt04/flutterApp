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

class ConfigResp{
  final String model;
  final String api_key;
  final String keyy;
  final String disabled;
  final String netmask;
  final String gateway;
  final String ipaddr;
  final String proto;
  final String mode;
  final String tcp_port;
  final String rain_send_url;
  final String timezone;
  final String datetime;

  ConfigResp._({this.model, this.api_key, this.keyy, this.disabled, this.netmask, this.gateway, this.ipaddr, this.mode, this.proto, this.rain_send_url, this.tcp_port, this.datetime, this.timezone});

  factory ConfigResp.fromJson(Map<String, dynamic> json){
    return new ConfigResp._(
      api_key: json['api_key'],
      model: json['model'],
      gateway: json['gateway'],
      disabled: json['disabled'],
      netmask: json['netmask'],
      keyy: json['key'],
      ipaddr: json['ipaddr'],
      mode: json['mode'],
      proto: json['proto'],
      rain_send_url: json['rain_send_url'],
      tcp_port: json['tcp_port'],
      timezone: json['timezone'],
      datetime: json['datetime']
    );
  }
}
