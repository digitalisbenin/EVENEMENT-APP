class TypeDemande {
  int? id;
  String? name;
  int? prix;

  TypeDemande({
    this.id,
    this.name,
    this.prix,
  });

  factory TypeDemande.fromJson(Map<String, dynamic> json) => TypeDemande(
    id: json["id"],
    name: json["name"],
    prix: json["prix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "prix": prix,
  };
}