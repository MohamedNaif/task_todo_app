class Authinfo {
  String? id;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  Authinfo({
    this.id,
    this.displayName,
    this.accessToken,
    this.refreshToken,
  });

  factory Authinfo.fromJson(Map<String, dynamic> json) => Authinfo(
        id: json['_id'] as String?,
        displayName: json['displayName'] as String?,
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'displayName': displayName,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
