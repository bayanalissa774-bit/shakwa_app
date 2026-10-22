class CitizenEntity {
  final int? citizenNumber;
  final String citizenName;
  final String phoneNumber;
  final String email;
  final String nationalId;
  final String? address;
  final String? identityImage;

  const CitizenEntity({
    this.citizenNumber,
    required this.citizenName,
    required this.phoneNumber,
    required this.email,
    required this.nationalId,
    this.address,
    this.identityImage,
  });
}
