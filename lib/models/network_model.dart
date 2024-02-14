class Teams {
  Teams({
    /// Team ID of the Team
    required this.teamId,
    required this.teamName,
    required this.teamEmail,
  });

  /// Team ID of the Team
  final String teamId;

  /// Team name of the Team
  final String teamName;

  /// Team Email of Team
  final DateTime teamEmail;

  Teams.fromMap(Map<String, dynamic> map)
      : teamId = map['team_id'],
        teamName = map['team_name'],
        teamEmail = map['team_email'];
}