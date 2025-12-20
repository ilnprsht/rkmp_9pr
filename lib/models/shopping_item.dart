import 'package:equatable/equatable.dart';

class ShoppingItem extends Equatable {
  final int productId;
  final bool isAdded;

  const ShoppingItem({
    required this.productId,
    this.isAdded = true,
  });

  ShoppingItem copyWith({
    int? productId,
    bool? isAdded,
  }) {
    return ShoppingItem(
      productId: productId ?? this.productId,
      isAdded: isAdded ?? this.isAdded,
    );
  }

  @override
  List<Object?> get props => [productId, isAdded];
}
