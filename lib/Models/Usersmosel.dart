// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Users {
  String? Name;
  String? Email;
  String? password;
  String? userId;
  String? Profilepic;
  Users({
    this.Name,
    this.Email,
    this.password,
    this.userId,
    this.Profilepic,
  });

  Users copyWith({
    String? Name,
    String? Email,
    String? password,
    String? userId,
    String? Profilepic,
  }) {
    return Users(
      Name: Name ?? this.Name,
      Email: Email ?? this.Email,
      password: password ?? this.password,
      userId: userId ?? this.userId,
      Profilepic: Profilepic ?? this.Profilepic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'Email': Email,
      'password': password,
      'userId': userId,
      'Profilepic': Profilepic,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      Name: map['Name'] != null ? map['Name'] as String : null,
      Email: map['Email'] != null ? map['Email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      Profilepic: map['Profilepic'] != null ? map['Profilepic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(Name: $Name, Email: $Email, password: $password, userId: $userId, Profilepic: $Profilepic)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;
  
    return 
      other.Name == Name &&
      other.Email == Email &&
      other.password == password &&
      other.userId == userId &&
      other.Profilepic == Profilepic;
  }

  @override
  int get hashCode {
    return Name.hashCode ^
      Email.hashCode ^
      password.hashCode ^
      userId.hashCode ^
      Profilepic.hashCode;
  }
}
