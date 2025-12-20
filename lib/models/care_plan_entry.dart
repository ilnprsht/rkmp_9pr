import 'package:equatable/equatable.dart';

class CarePlanEntry extends Equatable {
  final String day;
  final List<int> productIds;

  const CarePlanEntry({
    required this.day,
    required this.productIds,
  });

  CarePlanEntry copyWith({
    String? day,
    List<int>? productIds,
  }) {
    return CarePlanEntry(
      day: day ?? this.day,
      productIds: productIds ?? this.productIds,
    );
  }

  @override
  List<Object?> get props => [day, productIds];
}
