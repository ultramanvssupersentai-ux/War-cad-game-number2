// lib/models/game_state.dart
@freezed
class GameState with _$GameState {
  const factory GameState({
    required String gameId,
    required String currentTurnPlayerId,
    required List<GameCard> battlefield,   // ทุกการ์ดที่อยู่บนสนาม
    required Map<String, List<GameCard>> playerHands,     // มือผู้เล่น (ซ่อนจากอีกฝ่าย)
    required Map<String, List<GameCard>> playerResources, // ทรัพยากรที่ครอบครอง
    required Map<String, bool> playerReady, // พร้อมเริ่มหรือยัง
    String? winnerId,
    @Default(GamePhase.setup) GamePhase phase,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}

enum GamePhase { setup, planning, battle, end }
