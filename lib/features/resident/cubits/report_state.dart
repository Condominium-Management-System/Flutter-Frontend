
import 'package:equatable/equatable.dart';
import '../models/report_model.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportListLoaded extends ReportState {
  final List<ReportModel> reports;

  const ReportListLoaded({required this.reports});

  @override
  List<Object?> get props => [reports];
}

class ReportDetailsLoaded extends ReportState {
  final ReportModel report;

  const ReportDetailsLoaded({required this.report});

  @override
  List<Object?> get props => [report];
}

class ReportCreated extends ReportState {
  final ReportModel report;

  const ReportCreated({required this.report});

  @override
  List<Object?> get props => [report];
}

class ReportError extends ReportState {
  final String message;

  const ReportError({required this.message});

  @override
  List<Object?> get props => [message];
}