class SliceResponse<T> {
  final List<T> items;
  final bool hasMore;

  SliceResponse({required this.items, required this.hasMore});

  factory SliceResponse.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromItem,
  ) {
    final content = (map['content'] as List<dynamic>? ?? [])
        .map((e) => fromItem(e as Map<String, dynamic>))
        .toList();

    return SliceResponse(
      items: content,
      hasMore: !(map['last'] as bool? ?? true),
    );
  }
}
