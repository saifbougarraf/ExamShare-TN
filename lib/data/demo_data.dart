class Resource {
  const Resource({
    required this.id,
    required this.title,
    required this.level,
    required this.subject,
    required this.resourceType,
    required this.year,
    required this.description,
    required this.downloads,
    required this.points,
    required this.fileType,
    required this.ownerName,
  });

  final String id;
  final String title;
  final String level;
  final String subject;
  final String resourceType;
  final String year;
  final String description;
  final int downloads;
  final int points;
  final String fileType;
  final String ownerName;
}
