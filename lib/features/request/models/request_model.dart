class RequestModel {
  RequestModel({
    required this.officeId,
    required this.pendingRequests,
  });

  final int? officeId;
  final List<PendingRequest> pendingRequests;

  RequestModel copyWith({
    int? officeId,
    List<PendingRequest>? pendingRequests,
  }) {
    return RequestModel(
      officeId: officeId ?? this.officeId,
      pendingRequests: pendingRequests ?? this.pendingRequests,
    );
  }

  factory RequestModel.fromJson(Map<String, dynamic> json){
    return RequestModel(
      officeId: json["office_id"],
      pendingRequests: json["pending_requests"] == null ? [] : List<PendingRequest>.from(json["pending_requests"]!.map((x) => PendingRequest.fromJson(x))),
    );
  }

}

class PendingRequest {
  PendingRequest({
    required this.requestId,
    required this.status,
    required this.propertyId,
    required this.regionId,
    required this.price,
    required this.title,
    required this.space,
    required this.descriptionProperty,
    required this.descriptionLocation,
    required this.contractType,
    required this.propertyCategory,
    required this.propertyType,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.userImage,
    required this.userPhone,
    required this.regionName,
    required this.stateId,
    required this.stateName,
    required this.images,
  });

  final int? requestId;
  final String? status;
  final int? propertyId;
  final int? regionId;
  final int? price;
  final String? title;
  final int? space;
  final String? descriptionProperty;
  final dynamic descriptionLocation;
  final String? contractType;
  final String? propertyCategory;
  final String? propertyType;
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? userEmail;
  final dynamic userImage;
  final String? userPhone;
  final String? regionName;
  final int? stateId;
  final String? stateName;
  final List<String> images;

  PendingRequest copyWith({
    int? requestId,
    String? status,
    int? propertyId,
    int? regionId,
    int? price,
    String? title,
    int? space,
    String? descriptionProperty,
    dynamic? descriptionLocation,
    String? contractType,
    String? propertyCategory,
    String? propertyType,
    int? userId,
    String? firstName,
    String? lastName,
    String? userEmail,
    dynamic? userImage,
    String? userPhone,
    String? regionName,
    int? stateId,
    String? stateName,
    List<String>? images,
  }) {
    return PendingRequest(
      requestId: requestId ?? this.requestId,
      status: status ?? this.status,
      propertyId: propertyId ?? this.propertyId,
      regionId: regionId ?? this.regionId,
      price: price ?? this.price,
      title: title ?? this.title,
      space: space ?? this.space,
      descriptionProperty: descriptionProperty ?? this.descriptionProperty,
      descriptionLocation: descriptionLocation ?? this.descriptionLocation,
      contractType: contractType ?? this.contractType,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      propertyType: propertyType ?? this.propertyType,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userEmail: userEmail ?? this.userEmail,
      userImage: userImage ?? this.userImage,
      userPhone: userPhone ?? this.userPhone,
      regionName: regionName ?? this.regionName,
      stateId: stateId ?? this.stateId,
      stateName: stateName ?? this.stateName,
      images: images ?? this.images,
    );
  }

  factory PendingRequest.fromJson(Map<String, dynamic> json){
    return PendingRequest(
      requestId: json["request_id"],
      status: json["status"],
      propertyId: json["property_id"],
      regionId: json["region_id"],
      price: json["price"],
      title: json["title"],
      space: json["space"],
      descriptionProperty: json["description_property"],
      descriptionLocation: json["description_location"],
      contractType: json["contract_type"],
      propertyCategory: json["property_category"],
      propertyType: json["property_type"],
      userId: json["user_id"],
      firstName: json["FirstName"],
      lastName: json["LastName"],
      userEmail: json["user_email"],
      userImage: json["user_image"],
      userPhone: json["user_phone"],
      regionName: json["region_Name"],
      stateId: json["state_id"],
      stateName: json["state_name"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );
  }

}
