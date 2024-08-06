import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Address {
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class Geo {
  Geo({
    required this.lat,
    required this.lng,
  });

  final String? lat;
  final String? lng;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

@JsonSerializable()
class Company {
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  final String? name;
  final String? catchPhrase;
  final String? bs;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
