
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_state.dart';
import '../repositories/payment_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository = getIt<PaymentRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  PaymentCubit() : super(PaymentInitial());

// LOAD PAYMENTS
  Future<void> loadPayments({
    String? status,
    String? paymentType,
    String? monthYear,
    int page = 1,
    int limit = 20,
  }) async {
    emit(PaymentLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const PaymentError(message: 'No internet connection.'));
        return;
      }

      final payments = await _paymentRepository.getMyPayments(
        status: status,
        paymentType: paymentType,
        monthYear: monthYear,
        page: page,
        limit: limit,
      );
      emit(PaymentListLoaded(payments: payments));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  // LOAD MORE PAYMENTS
  Future<void> loadMorePayments({
    String? status,
    String? paymentType,
    String? monthYear,
  }) async {
    final currentState = state;
    if (currentState is PaymentListLoaded) {
      final nextPage = currentState.currentPage + 1;
      emit(PaymentLoadingMore(payments: currentState.payments));

      try {
        final newPayments = await _paymentRepository.getMyPayments(
          status: status,
          paymentType: paymentType,
          monthYear: monthYear,
          page: nextPage,
          limit: 20,
        );

        if (newPayments.isEmpty) {
          emit(currentState.copyWith(hasMore: false));
          return;
        }

        final allPayments = [...currentState.payments, ...newPayments];
        emit(PaymentListLoaded(
          payments: allPayments,
          currentPage: nextPage,
          hasMore: newPayments.length == 20,
        ));
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    }
  }

  // PAYMENT DETAILS
  Future<void> loadPaymentDetails(String id) async {
    emit(PaymentLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const PaymentError(message: 'No internet connection.'));
        return;
      }

      final payment = await _paymentRepository.getPaymentDetails(id);
      emit(PaymentDetailsLoaded(payment: payment));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  // MAKE PAYMENT
  Future<void> makePayment({
    required String paymentType,
    required double amount,
    required String paymentMethod,
    String? equbId,
    String? iddirId,
    String? monthYear,
    String? receiptPath,
  }) async {
    emit(PaymentLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const PaymentError(message: 'No internet connection.'));
        return;
      }

      final payment = await _paymentRepository.makePayment(
        paymentType: paymentType,
        amount: amount,
        paymentMethod: paymentMethod,
        equbId: equbId,
        iddirId: iddirId,
        monthYear: monthYear,
        receiptPath: receiptPath,
      );
      emit(PaymentCreated(payment: payment));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  // GET PAYMENT METHODS
  Future<void> loadPaymentMethods() async {
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const PaymentError(message: 'No internet connection.'));
        return;
      }

      final methods = await _paymentRepository.getPaymentMethods();
      emit(PaymentMethodsLoaded(methods: methods));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  // CLEAR ERROR
  void clearError() {
    if (state is PaymentError) {
      emit(PaymentInitial());
    }
  }

  // RESET
  void reset() {
    emit(PaymentInitial());
  }
}