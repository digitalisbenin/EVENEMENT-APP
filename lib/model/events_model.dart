import 'package:new_digitalis_event_app/model/type_demande_model.dart';

class Event {
  int? id;
  String? name;
  String? description;
  DateTime? dateDebuit;
  DateTime? dateFin;
  String? lieu;
  String? telephone;
  String? image;
  String? video;
  int? montant;
  int? isCorrect;
  String? status;
  TypeDemande? typeDemande;

  Event({
     this.id,
     this.name,
     this.description,
     this.dateDebuit,
     this.dateFin,
     this.lieu,
     this.telephone,
     this.image,
     this.video,
     this.montant,
     this.isCorrect,
     this.status,
     this.typeDemande,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    dateDebuit: DateTime.parse(json["date_debuit"]),
    dateFin: DateTime.parse(json["date_fin"]),
    lieu: json["lieu"],
    telephone: json["telephone"],
    image: json["image"],
    video: json["video"],
    montant: json["montant"],
    isCorrect: json["is_correct"],
    status: json["status"],
    typeDemande: TypeDemande.fromJson(json["type_demande"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "date_debuit": dateDebuit!.toIso8601String(),
    "date_fin": dateFin!.toIso8601String(),
    "lieu": lieu,
    "telephone": telephone,
    "image": image,
    "video": video,
    "montant": montant,
    "is_correct": isCorrect,
    "status": status,
    "type_demande": typeDemande!.toJson(),
  };
}