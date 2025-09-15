class AcceptPropertyModel {
  AcceptPropertyModel({
    required this.propertyId,
    required this.title,
    required this.price,
    required this.space,
    required this.contractType,
    required this.propertyCategory,
    required this.propertyType,
    required this.descriptionProperty,
    required this.descriptionLocation,
    required this.region,
    required this.user,
    required this.images,
    required this.pivot,
  });

  final int? propertyId;
  final String? title;
  final int? price;
  final int? space;
  final String? contractType;
  final String? propertyCategory;
  final String? propertyType;
  final String? descriptionProperty;
  final dynamic descriptionLocation;
  final Region? region;
  final User? user;
  final List<String> images;
  final Pivot? pivot;

  AcceptPropertyModel copyWith({
    int? propertyId,
    String? title,
    int? price,
    int? space,
    String? contractType,
    String? propertyCategory,
    String? propertyType,
    String? descriptionProperty,
    dynamic? descriptionLocation,
    Region? region,
    User? user,
    List<String>? images,
    Pivot? pivot,
  }) {
    return AcceptPropertyModel(
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      price: price ?? this.price,
      space: space ?? this.space,
      contractType: contractType ?? this.contractType,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      propertyType: propertyType ?? this.propertyType,
      descriptionProperty: descriptionProperty ?? this.descriptionProperty,
      descriptionLocation: descriptionLocation ?? this.descriptionLocation,
      region: region ?? this.region,
      user: user ?? this.user,
      images: images ?? this.images,
      pivot: pivot ?? this.pivot,
    );
  }

  factory AcceptPropertyModel.fromJson(Map<String, dynamic> json){
    return AcceptPropertyModel(
      propertyId: json["property_id"],
      title: json["title"],
      price: json["price"],
      space: json["space"],
      contractType: json["contract_type"],
      propertyCategory: json["property_category"],
      propertyType: json["property_type"],
      descriptionProperty: json["description_property"],
      descriptionLocation: json["description_location"],
      region: json["region"] == null ? null : Region.fromJson(json["region"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }

}

class Pivot {
  Pivot({
    required this.officeId,
    required this.propertyId,
    required this.id,
    required this.isFeatured,
    required this.status,
    required this.createdAt,
  });

  final int? officeId;
  final int? propertyId;
  final int? id;
  final int? isFeatured;
  final String? status;
  final DateTime? createdAt;

  Pivot copyWith({
    int? officeId,
    int? propertyId,
    int? id,
    int? isFeatured,
    String? status,
    DateTime? createdAt,
  }) {
    return Pivot(
      officeId: officeId ?? this.officeId,
      propertyId: propertyId ?? this.propertyId,
      id: id ?? this.id,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Pivot.fromJson(Map<String, dynamic> json){
    return Pivot(
      officeId: json["office_id"],
      propertyId: json["property_id"],
      id: json["id"],
      isFeatured: json["is_featured"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}

class Region {
  Region({
    required this.id,
    required this.name,
    required this.state,
  });

  final int? id;
  final String? name;
  final State? state;

  Region copyWith({
    int? id,
    String? name,
    State? state,
  }) {
    return Region(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
    );
  }

  factory Region.fromJson(Map<String, dynamic> json){
    return Region(
      id: json["id"],
      name: json["name"],
      state: json["state"] == null ? null : State.fromJson(json["state"]),
    );
  }

}

class State {
  State({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  State copyWith({
    int? id,
    String? name,
  }) {
    return State(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory State.fromJson(Map<String, dynamic> json){
    return State(
      id: json["id"],
      name: json["name"],
    );
  }

}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final dynamic image;

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    dynamic? image,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
    );
  }

}
