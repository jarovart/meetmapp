class UpdateThumbnailRequest {
  final int imageId;

  UpdateThumbnailRequest({required this.imageId});

  Map<String, dynamic> toMap() {
    return {"imageId": imageId};
  }
}
