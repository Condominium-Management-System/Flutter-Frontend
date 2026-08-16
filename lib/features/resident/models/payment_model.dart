
import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  final String id;
  final String userId;
  final String condoId;
  final String paymentType;
  final double amount;
  final String monthYear;
  final String status;
  final String paymentMethod;
  final String? paymentDate;
  final String? adminNotes;
  final String? approvedBy;
  final String? approvalDate;
  final String? receiptUrl;
  final String? txRef;
  final String createdAt;
  final String updatedAt;

  const PaymentModel({
    required this.id,
    required this.userId,
    required this.condoId,
    required this.paymentType,
    required this.amount,
    required this.monthYear,
    required this.status,
    required this.paymentMethod,
    this.paymentDate,
    this.adminNotes,
    this.approvedBy,
    this.approvalDate,
    this.receiptUrl,
    this.txRef,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      paymentType: json['paymentType'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      monthYear: json['monthYear'] as String? ?? '',
      status: json['status'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      paymentDate: json['paymentDate'] as String?,
      adminNotes: json['adminNotes'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvalDate: json['approvalDate'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
      txRef: json['txRef'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'condoId': condoId,
      'paymentType': paymentType,
      'amount': amount,
      'monthYear': monthYear,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentDate': paymentDate,
      'adminNotes': adminNotes,
      'approvedBy': approvedBy,
      'approvalDate': approvalDate,
      'receiptUrl': receiptUrl,
      'txRef': txRef,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Payment Status helpers
  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'approved':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        condoId,
        paymentType,
        amount,
        monthYear,
        status,
        paymentMethod,
        paymentDate,
        adminNotes,
        approvedBy,
        approvalDate,
        receiptUrl,
        txRef,
        createdAt,
        updatedAt,
      ];
}