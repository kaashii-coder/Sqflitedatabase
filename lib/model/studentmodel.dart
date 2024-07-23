class StudentModel {
  int? id;
  final String name;
  final String age;
  final String domain;
  final String address;
  final String image;

  StudentModel({
    required this.name,
    required this.age,
    required this.domain,
    required this.address,
     required this.image,
    this.id,
  });
  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final domain = map['domain'] as String;
    final address = map['address'] as String;
    final  image = map['image'] as String ;
    return StudentModel(
        id: id,
        name: name,
        age: age,
        domain: domain,
        address: address,
        image:image );
  }
}
