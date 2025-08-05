part of 'service_category_cubit.dart';

enum ServiceCategoryStatus { initial, loading, success, error }

class ServiceCategoryState extends Equatable {
  final ServiceCategoryStatus status;
  final String message;
  final List<ServiceCategoryModel> categoryList;

  const ServiceCategoryState({required this.status, required this.message, required this.categoryList});

  factory ServiceCategoryState.initial() {
    return ServiceCategoryState(status: ServiceCategoryStatus.initial, message: '', categoryList: []);
  }

  ServiceCategoryState copyWith({ServiceCategoryStatus? status, String? message, List<ServiceCategoryModel>? categoryList}) {
    return ServiceCategoryState(
      status: status ?? this.status,
      message: message ?? this.message,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  @override
  List<Object?> get props => [status, message, categoryList];
}
