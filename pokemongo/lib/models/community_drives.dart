class CommunityDrive {
  final String id;
  final String imageUrl;
  final String username;
  final String eventDate;
  final String eventDetails;
  final String location;

  CommunityDrive({
    required this.id,
    required this.imageUrl,
    required this.username,
    required this.eventDate,
    required this.eventDetails,
    required this.location,
  });

  factory CommunityDrive.fromJson(Map<String, dynamic> json) {
    return CommunityDrive(
      id: json['_id'] ?? '',
      location: json['address'] ?? 'Unknown',
      imageUrl: json['imgUrl'] ?? '', // Keeping it empty if null
      username: json['user']['username'] ?? 'Unknown',
      eventDate: json['eventDate'] ?? 'Sardar Patel College of Engineering',
      eventDetails: json['description']?.isNotEmpty == true
          ? json['description']
          : 'No details available', // Fix: Handle empty description
    );
  }
}
