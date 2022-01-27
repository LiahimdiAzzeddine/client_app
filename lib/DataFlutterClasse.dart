class DataFlutter {
  String? nom;
  String? email;
  String? age;

  DataFlutter({this.nom, this.email, this.age});

  DataFlutter.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    email = json['email'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['email'] = this.email;
    data['age'] = this.age;
    return data;
  }
}