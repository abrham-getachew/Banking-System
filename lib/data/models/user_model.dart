class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BiometricData? biometricData;
  final bool isVerified;
  final List<String> permissions;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.biometricData,
    required this.isVerified,
    required this.permissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImageUrl: json['profileImageUrl'],
      phoneNumber: json['phoneNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      biometricData: json['biometricData'] != null
          ? BiometricData.fromJson(json['biometricData'])
          : null,
      isVerified: json['isVerified'] ?? false,
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'biometricData': biometricData?.toJson(),
      'isVerified': isVerified,
      'permissions': permissions,
    };
  }
}

class BiometricData {
  final String fingerprintHash;
  final String faceHash;
  final bool isFingerprintEnabled;
  final bool isFaceEnabled;
  final DateTime lastAuthenticated;

  BiometricData({
    required this.fingerprintHash,
    required this.faceHash,
    required this.isFingerprintEnabled,
    required this.isFaceEnabled,
    required this.lastAuthenticated,
  });

  factory BiometricData.fromJson(Map<String, dynamic> json) {
    return BiometricData(
      fingerprintHash: json['fingerprintHash'],
      faceHash: json['faceHash'],
      isFingerprintEnabled: json['isFingerprintEnabled'] ?? false,
      isFaceEnabled: json['isFaceEnabled'] ?? false,
      lastAuthenticated: DateTime.parse(json['lastAuthenticated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fingerprintHash': fingerprintHash,
      'faceHash': faceHash,
      'isFingerprintEnabled': isFingerprintEnabled,
      'isFaceEnabled': isFaceEnabled,
      'lastAuthenticated': lastAuthenticated.toIso8601String(),
    };
  }
}
