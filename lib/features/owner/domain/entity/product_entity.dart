import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final int rewardPts;
  final String categoryName;
  final int? threshold;
  final String imageUrl;
  final String? status;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rewardPts,
    required this.categoryName,
    required this.imageUrl,
    this.threshold,
    this.status,
  });

  ProductEntity copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? rewardPts,
    String? categoryName,
    int? threshold,
    String? imageUrl,
    String? status,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      rewardPts: rewardPts ?? this.rewardPts,
      categoryName: categoryName ?? this.categoryName,
      threshold: threshold ?? this.threshold,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    rewardPts,
    categoryName,
    threshold,
    imageUrl,
    status,
  ];
}
