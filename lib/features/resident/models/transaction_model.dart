
import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final String referenceNo;
  final double amount;
  final String status;
  final String? paymentType;
  final String? paymentMethod;
  final String? monthYear;
  final String createdAt;

  const TransactionModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.referenceNo,
    required this.amount,
    required this.status,
    this.paymentType,
    this.paymentMethod,
    this.monthYear,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      senderName: json['senderName'] as String? ?? '',
      receiverId: json['receiverId'] as String? ?? '',
      receiverName: json['receiverName'] as String? ?? '',
      referenceNo: json['referenceNo'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      paymentType: json['paymentType'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      monthYear: json['monthYear'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'referenceNo': referenceNo,
      'amount': amount,
      'status': status,
      'paymentType': paymentType,
      'paymentMethod': paymentMethod,
      'monthYear': monthYear,
      'createdAt': createdAt,
    };
  }

  // Status helpers
  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
  bool get isReversed => status == 'reversed';

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      case 'reversed':
        return 'Reversed';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        senderId,
        senderName,
        receiverId,
        receiverName,
        referenceNo,
        amount,
        status,
        paymentType,
        paymentMethod,
        monthYear,
        createdAt,
      ];
}