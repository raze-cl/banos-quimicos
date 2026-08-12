class VehicleModel {
  final String id;
  final String plateNumber;
  final String brand;
  final String model;
  final int year;
  final int lastOdometer;
  final String qrCodeToken;
  final bool isActive;

  VehicleModel({
    required this.id,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.year,
    required this.lastOdometer,
    required this.qrCodeToken,
    required this.isActive,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as String,
      plateNumber: json['plateNumber'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      lastOdometer: json['lastOdometer'] as int,
      qrCodeToken: json['qrCodeToken'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'brand': brand,
      'model': model,
      'year': year,
      'lastOdometer': lastOdometer,
      'qrCodeToken': qrCodeToken,
      'isActive': isActive,
    };
  }
}
