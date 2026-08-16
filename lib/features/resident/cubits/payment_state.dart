
import 'package:equatable/equatable.dart';
import '../models/payment_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE

class PaymentInitial extends PaymentState {}

// LOADING STATE

class PaymentLoading extends PaymentState {}

class PaymentLoadingMore extends PaymentState {
  final List<PaymentModel> payments;

  const PaymentLoadingMore({required this.payments});

  @override
  List<Object?> get props => [payments];
}

// LIST LOADED STATE

class PaymentListLoaded extends PaymentState {
  final List<PaymentModel> payments;
  final int currentPage;
  final bool hasMore;

  const PaymentListLoaded({
    required this.payments,
    this.currentPage = 1,
    this.hasMore = true,
  });

  PaymentListLoaded copyWith({
    List<PaymentModel>? payments,
    int? currentPage,
    bool? hasMore,
  }) {
    return PaymentListLoaded(
      payments: payments ?? this.payments,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [payments, currentPage, hasMore];
}

// DETAILS LOADED STATE

class PaymentDetailsLoaded extends PaymentState {
  final PaymentModel payment;

  const PaymentDetailsLoaded({required this.payment});

  @override
  List<Object?> get props => [payment];
}

// PAYMENT CREATED STATE

class PaymentCreated extends PaymentState {
  final PaymentModel payment;

  const PaymentCreated({required this.payment});

  @override
  List<Object?> get props => [payment];
}

// PAYMENT METHODS LOADED

class PaymentMethodsLoaded extends PaymentState {
  final List<String> methods;

  const PaymentMethodsLoaded({required this.methods});

  @override
  List<Object?> get props => [methods];
}

// ERROR STATE

class PaymentError extends PaymentState {
  final String message;

  const PaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}