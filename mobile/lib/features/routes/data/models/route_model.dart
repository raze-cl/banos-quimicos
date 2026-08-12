class RoutePointModel {
  final String id;
  final String routeId;
  final String name;
  final String qrCodeToken;
  final int sequenceOrder;
  final String status; // PENDING, COMPLETED, OMITTED

  RoutePointModel({
    required this.id,
    required this.routeId,
    required this.name,
    required this.qrCodeToken,
    required this.sequenceOrder,
    required this.status,
  });

  factory RoutePointModel.fromJson(Map<String, dynamic> json) {
    return RoutePointModel(
      id: json['id'] as String,
      routeId: json['routeId'] as String,
      name: json['name'] as String,
      qrCodeToken: json['qrCodeToken'] as String,
      sequenceOrder: json['sequenceOrder'] as int? ?? 0,
      status: json['status'] as String? ?? 'PENDING',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'routeId': routeId,
      'name': name,
      'qrCodeToken': qrCodeToken,
      'sequenceOrder': sequenceOrder,
      'status': status,
    };
  }
}

class RouteModel {
  final String id;
  final String name;
  final String clientName;
  final String faenaName;
  final String status; // PENDING, IN_PROGRESS, COMPLETED
  final String scheduledDate;
  final List<RoutePointModel> points;

  RouteModel({
    required this.id,
    required this.name,
    required this.clientName,
    required this.faenaName,
    required this.status,
    required this.scheduledDate,
    this.points = const [],
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ptsJson = json['points'] ?? [];
    return RouteModel(
      id: json['id'] as String,
      name: json['name'] as String,
      clientName: json['clientName'] as String,
      faenaName: json['faenaName'] as String,
      status: json['status'] as String? ?? 'PENDING',
      scheduledDate: json['scheduledDate'] as String,
      points: ptsJson.map((e) => RoutePointModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'clientName': clientName,
      'faenaName': faenaName,
      'status': status,
      'scheduledDate': scheduledDate,
      'points': points.map((e) => e.toJson()).toList(),
    };
  }

  double get completionPercentage {
    if (points.isEmpty) return 0.0;
    final completedCount = points.where((p) => p.status != 'PENDING').length;
    return (completedCount / points.length) * 100;
  }
}
