enum DocumentStatus { green, yellow, red }

class DocumentModel {
  final String id;
  final String documentType; // IDENTITY_CARD, DRIVERS_LICENSE, MEDICAL_EXAM, FAENA_PASS
  final String emissionDate;
  final String expiryDate;
  final String? fileUrl;

  DocumentModel({
    required this.id,
    required this.documentType,
    required this.emissionDate,
    required this.expiryDate,
    this.fileUrl,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as String,
      documentType: json['documentType'] as String,
      emissionDate: json['emissionDate'] as String,
      expiryDate: json['expiryDate'] as String,
      fileUrl: json['fileUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentType': documentType,
      'emissionDate': emissionDate,
      'expiryDate': expiryDate,
      'fileUrl': fileUrl,
    };
  }

  int get daysToExpiry {
    final expiry = DateTime.parse(expiryDate);
    final today = DateTime.now();
    return expiry.difference(DateTime(today.year, today.month, today.day)).inDays;
  }

  DocumentStatus get status {
    final days = daysToExpiry;
    if (days > 60) {
      return DocumentStatus.green;
    } else if (days >= 30) {
      return DocumentStatus.yellow;
    } else {
      return DocumentStatus.red;
    }
  }

  String get documentName {
    switch (documentType) {
      case 'IDENTITY_CARD':
        return 'Cédula de Identidad';
      case 'DRIVERS_LICENSE':
        return 'Licencia Municipal';
      case 'MEDICAL_EXAM':
        return 'Examen Médico';
      case 'FAENA_PASS':
        return 'Pase de Faena';
      default:
        return documentType;
    }
  }
}
