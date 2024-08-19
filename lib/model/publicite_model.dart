class PubliciteModel {
  int? id;
  String? name;
  String? description;
  String? image;
  dynamic? video;
  dynamic? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PubliciteModel({
     this.id,
     this.name,
     this.description,
     this.image,
     this.video,
     this.userId,
     this.createdAt,
     this.updatedAt,
  });

  factory PubliciteModel.fromJson(Map<String, dynamic> json) => PubliciteModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    video: json["video"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "video": video,
    "user_id": userId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}