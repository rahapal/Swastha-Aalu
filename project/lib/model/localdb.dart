import 'package:hive/hive.dart';

part 'localdb.g.dart';

@HiveType(typeId: 0)
class Details {
  @HiveField(0)
  String image;
  @HiveField(1)
  String disease;
  @HiveField(2)
  String percentage;

  Details({
    required this.image,
    this.disease = 'ok',
    this.percentage = 'ok',
  });
}
