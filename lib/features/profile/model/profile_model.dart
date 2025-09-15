class ProfileModel {
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.description,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
    required this.followersCount,
    required this.acceptedPropertiesCount,
    required this.pendingPropertiesCount,
    required this.followers,
    required this.acceptedProperties,
    required this.pendingProperties,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? description;
  final String? percentage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? followersCount;
  final int? acceptedPropertiesCount;
  final int? pendingPropertiesCount;
  final List<Follower> followers;
  final List<Property> acceptedProperties;
  final List<Property> pendingProperties;

  ProfileModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? description,
    String? percentage,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? followersCount,
    int? acceptedPropertiesCount,
    int? pendingPropertiesCount,
    List<Follower>? followers,
    List<Property>? acceptedProperties,
    List<Property>? pendingProperties,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      description: description ?? this.description,
      percentage: percentage ?? this.percentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      followersCount: followersCount ?? this.followersCount,
      acceptedPropertiesCount: acceptedPropertiesCount ?? this.acceptedPropertiesCount,
      pendingPropertiesCount: pendingPropertiesCount ?? this.pendingPropertiesCount,
      followers: followers ?? this.followers,
      acceptedProperties: acceptedProperties ?? this.acceptedProperties,
      pendingProperties: pendingProperties ?? this.pendingProperties,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
      description: json["description"],
      percentage: json["percentage"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      followersCount: json["followers_count"],
      acceptedPropertiesCount: json["accepted_properties_count"],
      pendingPropertiesCount: json["pending_properties_count"],
      followers: json["followers"] == null ? [] : List<Follower>.from(json["followers"]!.map((x) => Follower.fromJson(x))),
      acceptedProperties: json["accepted_properties"] == null ? [] : List<Property>.from(json["accepted_properties"]!.map((x) => Property.fromJson(x))),
      pendingProperties: json["pending_properties"] == null ? [] : List<Property>.from(json["pending_properties"]!.map((x) => Property.fromJson(x))),
    );
  }

}

class Property {
  Property({
    required this.propertyId,
    required this.title,
    required this.price,
    required this.space,
    required this.regionId,
    required this.contractType,
    required this.propertyCategory,
    required this.propertyType,
    required this.descriptionProperty,
    required this.descriptionLocation,
    required this.pivot,
  });

  final int? propertyId;
  final String? title;
  final double? price;
  final double? space;
  final int? regionId;
  final String? contractType;
  final String? propertyCategory;
  final String? propertyType;
  final String? descriptionProperty;
  final String? descriptionLocation;
  final AcceptedPropertyPivot? pivot;

  Property copyWith({
    int? propertyId,
    String? title,
    double? price,
    double? space,
    int? regionId,
    String? contractType,
    String? propertyCategory,
    String? propertyType,
    String? descriptionProperty,
    String? descriptionLocation,
    AcceptedPropertyPivot? pivot,
  }) {
    return Property(
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      price: price ?? this.price,
      space: space ?? this.space,
      regionId: regionId ?? this.regionId,
      contractType: contractType ?? this.contractType,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      propertyType: propertyType ?? this.propertyType,
      descriptionProperty: descriptionProperty ?? this.descriptionProperty,
      descriptionLocation: descriptionLocation ?? this.descriptionLocation,
      pivot: pivot ?? this.pivot,
    );
  }

  factory Property.fromJson(Map<String, dynamic> json){
    return Property(
      propertyId: json["property_id"],
      title: json["title"],
      price: json["price"].toDouble(),
      space: json["space"].toDouble(),
      regionId: json["region_id"],
      contractType: json["contract_type"],
      propertyCategory: json["property_category"],
      propertyType: json["property_type"],
      descriptionProperty: json["description_property"],
      descriptionLocation: json["description_location"],
      pivot: json["pivot"] == null ? null : AcceptedPropertyPivot.fromJson(json["pivot"]),
    );
  }

}

class AcceptedPropertyPivot {
  AcceptedPropertyPivot({
    required this.officeId,
    required this.propertyId,
    required this.price,
    required this.status,
    required this.isFeatured,
  });

  final int? officeId;
  final int? propertyId;
  final String? price;
  final String? status;
  final int? isFeatured;

  AcceptedPropertyPivot copyWith({
    int? officeId,
    int? propertyId,
    String? price,
    String? status,
    int? isFeatured,
  }) {
    return AcceptedPropertyPivot(
      officeId: officeId ?? this.officeId,
      propertyId: propertyId ?? this.propertyId,
      price: price ?? this.price,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  factory AcceptedPropertyPivot.fromJson(Map<String, dynamic> json){
    return AcceptedPropertyPivot(
      officeId: json["office_id"],
      propertyId: json["property_id"],
      price: json["price"],
      status: json["status"],
      isFeatured: json["is_featured"],
    );
  }

}

class Follower {
  Follower({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.phoneNumber,
    required this.pivot,
  });

  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? image;
  final String? phoneNumber;
  final FollowerPivot? pivot;

  Follower copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? image,
    String? phoneNumber,
    FollowerPivot? pivot,
  }) {
    return Follower(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pivot: pivot ?? this.pivot,
    );
  }

  factory Follower.fromJson(Map<String, dynamic> json){
    return Follower(
      userId: json["user_id"],
      firstName: json["FirstName"],
      lastName: json["LastName"],
      email: json["email"],
      image: json["image"],
      phoneNumber: json["PhoneNumber"],
      pivot: json["pivot"] == null ? null : FollowerPivot.fromJson(json["pivot"]),
    );
  }

}

class FollowerPivot {
  FollowerPivot({
    required this.officeId,
    required this.userId,
  });

  final int? officeId;
  final int? userId;

  FollowerPivot copyWith({
    int? officeId,
    int? userId,
  }) {
    return FollowerPivot(
      officeId: officeId ?? this.officeId,
      userId: userId ?? this.userId,
    );
  }

  factory FollowerPivot.fromJson(Map<String, dynamic> json){
    return FollowerPivot(
      officeId: json["office_id"],
      userId: json["user_id"],
    );
  }

}
