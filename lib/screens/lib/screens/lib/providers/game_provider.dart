// lib/providers/game_provider.dart
final gameProvider = StreamProvider.family<GameState, String>((ref, gameId) {
  return FirebaseFirestore.instance
      .collection('games')
      .doc(gameId)
      .snapshots()
      .map((snap) => GameState.fromJson(snap.data()!));
});
