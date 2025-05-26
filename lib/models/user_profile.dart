class UserProfile {
  
  final String fullName;
  final String? bio;
  final String? degreeOrCompany;
  final String? country;
  final String role; // 'client' or 'developer'
  final String? interest; // For developers
  final List<String>? skills; // For developers
  final List<String>? jobHistory;
  final String? imagePath;

  const UserProfile({
    required this.fullName,
    this.bio,
    this.degreeOrCompany,
    this.country,
    required this.role,
    this.interest,
    this.skills,
    this.jobHistory,
    this.imagePath,
  });

  // Add a copyWith method for easy updates
  UserProfile copyWith({
    String? fullName,
    String? bio,
    String? degreeOrCompany,
    String? country,
    String? role,
    String? interest,
    List<String>? skills,
    List<String>? jobHistory,
    String? imagePath,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      degreeOrCompany: degreeOrCompany ?? this.degreeOrCompany,
      country: country ?? this.country,
      role: role ?? this.role,
      interest: interest ?? this.interest,
      skills: skills ?? this.skills,
      jobHistory: jobHistory ?? this.jobHistory,
      imagePath: imagePath ?? this.imagePath,
    );
  }
} 