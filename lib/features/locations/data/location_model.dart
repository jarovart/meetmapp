class LocationModel {
  final String id;
  final String title;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final String date;
  final String imageUrl;

  LocationModel({
    required this.id,
    required this.title,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.imageUrl,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'].toString(),
      title: map['title'].toString(),
      address: map['address'].toString(),
      description: map['description'].toString(),
      latitude: double.parse(map['latitude'].toString()),
      longitude: double.parse(map['longitude'].toString()),
      date: map['date'].toString(),
      imageUrl: map['imageUrl'].toString(),
    );
  }
}
