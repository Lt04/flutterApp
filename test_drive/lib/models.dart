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

class BlocklyResp{
  final String region;
  final String q_dynamic;
  final String q_value;
  final String pyfile;
  final String xmlfile;
  final String status;

  BlocklyResp._({this.region, this.q_dynamic, this.q_value, this.pyfile, this.xmlfile, this.status});

  factory BlocklyResp.fromJson(Map<String, dynamic> json){
    return new BlocklyResp._(
      region: json['region'],
      q_dynamic: json['Q_dynamic'].toString(),
      q_value: json['Q_value'].toString(),
      pyfile: json['pyfile'],
      xmlfile: json['xmlfile'],
      status: json['status']
    );
  }
}


class UIDResp{
  final String uid;
  final String version;

  UIDResp._({this.uid, this.version});

  factory UIDResp.fromJson(Map<String, dynamic> json){
    return new UIDResp._(
      version: json['sw_version'],
      uid: json['uid'],
    );
  }
}

class CheckUpdateResp{
  final String status;
  final String version;
  final List<dynamic> versions;

  CheckUpdateResp._({this.status, this.version, this.versions});

  factory CheckUpdateResp.fromJson(Map<String, dynamic> json){
    return new CheckUpdateResp._(
      version: json['current_version'],
      status: json['status'],
      versions: json['available_versions']
    );
  }
}

class ListWifiResp{
  final String channel;
  final String ssid;
  final String bssid;
  final String cipher;
  final String encryptionString;
  final String encryption;
  final String signalStrength;
  final String wirelessMode;
  final String ext_ch;
  final String rssi;

  ListWifiResp._({this.bssid, this.channel, this.cipher, this.encryption, this.encryptionString, this.ext_ch, this.rssi, this.signalStrength, this.ssid, this.wirelessMode});

  factory ListWifiResp.fromJson(Map<String, dynamic> json){
    return new ListWifiResp._(
      bssid: json['bssid'],
      channel: json['channel'].toString(),
      ssid: json['ssid'],
      cipher: json['cipher'],
      encryption: json['encryption'],
      encryptionString: json['encryptionString'],
      signalStrength: json['signalStrength'].toString(),
      wirelessMode: json['wirelessMode'],
      ext_ch: json['ext-ch'],
      rssi: json['rssi'].toString()
    );
  }
}

class PassResp{
  final String errors;
  final Map<String, dynamic> validation;

  PassResp._({this.errors, this.validation});

  factory PassResp.fromJson(Map<String, dynamic> json){
    return new PassResp._(
      errors: json['errors'], 
      validation: json['validation']
    );
  }
}