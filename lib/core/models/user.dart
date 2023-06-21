import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String image;
  final String name;
  final String surname;
  final DateTime createdAt;
  UserModel({
    required this.id,
    required this.image,
    required this.name,
    required this.surname,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? image,
    String? name,
    String? surname,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'surname': surname,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      createdAt: map['createdAt'].toDate(),
    );
  }

  factory UserModel.empty() => UserModel(
        id: '',
        image: '',
        name: '',
        surname: '',
        createdAt: DateTime.now(),
      );
}
