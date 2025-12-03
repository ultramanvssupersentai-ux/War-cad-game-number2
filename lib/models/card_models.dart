// lib/models/card_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_models.freezed.dart';
part 'card_models.g.dart';

enum CardType {
  leader,           // ตัวแทนคนเล่น
  terrain,          // ภูมิประเทศ (คว่ำหน้า)
  base,             // ฐานทัพ
  unit,             // กองทัพ
  resource,         // ทรัพยากร (เงิน, แร่, ไม้)
  spy,              // จารชน/สายลับ
  intel,            // การ์ดข้อมูล
}

enum ResourceType { gold, ore, wood }

@freezed
class GameCard with _$GameCard {
  const factory GameCard({
    required String id,
    required String name,
    required CardType type,
    required String ownerId,        // ผู้เล่นที่ครอบครองจริง
    String? displayedOwnerId,      // สำหรับฝ่ายตรงข้ามเห็น (อาจเป็น fake ถ้าเป็นสายลับ)
    @Default(false) bool isFaceUp,  // คว่ำหน้าหรือไม่ (terrain, spy บางใบ)
    @Default(false) bool isTapped,
    ResourceType? resourceType,
    Map<String, dynamic>? effects,  // เก็บเอฟเฟกต์ต่าง ๆ
    String? terrainEffect,          // เช่น "ป้องกัน +2 ให้ทหารราบ"
  }) = _GameCard;

  factory GameCard.fromJson(Map<String, dynamic> json) =>
      _$GameCardFromJson(json);
}
