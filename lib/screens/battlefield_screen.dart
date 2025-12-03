// lib/screens/battlefield_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';

class BattlefieldScreen extends ConsumerWidget {
  final String gameId;
  final String playerId;

  const BattlefieldScreen({required this.gameId, required this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider(gameId));

    return Scaffold(
      appBar: AppBar(title: Text("สงครามการ์ด – รหัสห้อง: $gameId")),
      body: gameState.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (state) {
          final myField = state.battlefield
              .where((card) => card.ownerId == playerId)
              .toList();
          final opponentField = state.battlefield
              .where((card) => card.ownerId != playerId)
              .toList();

          return Column(
            children: [
              // === เขตฝ่ายตรงข้าม ===
              Expanded(
                child: BattlefieldZone(
                  cards: opponentField,
                  isMine: false,
                  playerId: playerId,
                  gameId: gameId,
                ),
              ),
              Divider(height: 4, thickness: 4),
              // === เขตของเรา ===
              Expanded(
                child: BattlefieldZone(
                  cards: myField,
                  isMine: true,
                  playerId: playerId,
                  gameId: gameId,
                ),
              ),
              // ปุ่มจบเทิร์น
              if (state.currentTurnPlayerId == playerId)
                ElevatedButton(
                  onPressed: () => ref.read(gameProvider(gameId).notifier).endTurn(),
                  child: Text("จบเทิร์น"),
                ),
            ],
          );
        },
      ),
    );
  }
}
