class Profile {
  int? id;
  String? name;
  String? email;
  int? roleId;
  String? token;
  String? emailVerifiedAt;
  String? twoFactorConfirmedAt;
  String? currentTeamId;
  String? profilePhotoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profilePhotoUrl;

  Profile({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.token,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    roleId: json["role_id"],
    token: json['token'], // Assurez-vous de bien récupérer le token
    emailVerifiedAt: json["email_verified_at"],
    twoFactorConfirmedAt: json["two_factor_confirmed_at"],
    currentTeamId: json["current_team_id"],
    profilePhotoPath: json["profile_photo_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role_id": roleId,
    "token": token,
    "email_verified_at": emailVerifiedAt,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "current_team_id": currentTeamId,
    "profile_photo_path": profilePhotoPath,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "profile_photo_url": profilePhotoUrl,
  };
}
