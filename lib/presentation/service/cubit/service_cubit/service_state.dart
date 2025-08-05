part of 'service_cubit.dart';

enum ServiceStatus { initial, loading, success, error, moreLoading }

class ServiceState extends Equatable {
  final ServiceStatus status;
  final String message;
  final ServiceResponseModel? serviceResponseModel;

  const ServiceState({required this.status, required this.message, this.serviceResponseModel});

  factory ServiceState.initial() {
    return ServiceState(status: ServiceStatus.initial, message: '', serviceResponseModel: null);
  }

  ServiceState copyWith({ServiceStatus? status, String? message, ServiceResponseModel? serviceResponseModel}) {
    return ServiceState(
      status: status ?? this.status,
      message: message ?? this.message,
      serviceResponseModel: serviceResponseModel ?? this.serviceResponseModel,
    );
  }

  @override
  List<Object?> get props => [status, message, serviceResponseModel];
}
