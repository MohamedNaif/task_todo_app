class Register {
  String? phone;
  String? password;
  String? displayName;
  int? experienceYears;
  String? address;
  String? level;

  Register({
    this.phone,
    this.password,
    this.displayName,
    this.experienceYears,
    this.address,
    this.level,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        phone: json['phone'] as String?,
        password: json['password'] as String?,
        displayName: json['displayName'] as String?,
        experienceYears: json['experienceYears'] as int?,
        address: json['address'] as String?,
        level: json['level'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
        'displayName': displayName,
        'experienceYears': experienceYears,
        'address': address,
        'level': level,
      };
}
