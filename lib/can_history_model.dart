class CANEdition {
  final String id;
  final int year;
  final String hostCountry;
  final String winner;
  final String runnerUp;
  final String thirdPlace;
  final String fourthPlace;
  final int totalTeams;
  final int totalMatches;
  final int totalGoals;
  final String topScorer;
  final int topScorerGoals;
  final String bestPlayer;
  final String bestGoalkeeper;
  final String bestYoungPlayer;
  final List<CANMatch> matches;
  final List<String> highlights;
  final String description;
  final String image;

  CANEdition({
    required this.id,
    required this.year,
    required this.hostCountry,
    required this.winner,
    required this.runnerUp,
    required this.thirdPlace,
    required this.fourthPlace,
    required this.totalTeams,
    required this.totalMatches,
    required this.totalGoals,
    required this.topScorer,
    required this.topScorerGoals,
    required this.bestPlayer,
    required this.bestGoalkeeper,
    required this.bestYoungPlayer,
    required this.matches,
    required this.highlights,
    required this.description,
    required this.image,
  });
}

class CANMatch {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String stage; // Group, Quarter-final, Semi-final, Final, Third place
  final String date;
  final String venue;
  final String city;
  final List<String> scorers;
  final String description;

  CANMatch({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.stage,
    required this.date,
    required this.venue,
    required this.city,
    required this.scorers,
    required this.description,
  });
}

class TopScorer {
  final String name;
  final String country;
  final int totalGoals;
  final List<String> editions;
  final String image;
  final String description;

  TopScorer({
    required this.name,
    required this.country,
    required this.totalGoals,
    required this.editions,
    required this.image,
    required this.description,
  });
}

class BestPlayer {
  final String name;
  final String country;
  final String position;
  final List<String> awards;
  final String image;
  final String description;

  BestPlayer({
    required this.name,
    required this.country,
    required this.position,
    required this.awards,
    required this.image,
    required this.description,
  });
}

class MostCappedPlayer {
  final String name;
  final String country;
  final int totalMatches;
  final int totalEditions;
  final String period;
  final String image;
  final String description;

  MostCappedPlayer({
    required this.name,
    required this.country,
    required this.totalMatches,
    required this.totalEditions,
    required this.period,
    required this.image,
    required this.description,
  });
}

class HistoricMoment {
  final String id;
  final String title;
  final String description;
  final String year;
  final String edition;
  final String image;
  final String category; // Goal, Save, Celebration, Controversy, etc.

  HistoricMoment({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.edition,
    required this.image,
    required this.category,
  });
} 