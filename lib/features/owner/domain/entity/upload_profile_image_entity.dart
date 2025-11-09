class UploadProfileImageEntity {
  final String imageUrl;
  final String message;

  const UploadProfileImageEntity({
    required this.imageUrl,
    required this.message,
  });

  UploadProfileImageEntity copyWith({
    String? imageUrl,
    String? message,
  }) {
    return UploadProfileImageEntity(
      imageUrl: imageUrl ?? this.imageUrl,
      message: message ?? this.message,
    );
  }
}
