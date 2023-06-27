import 'package:hive/hive.dart';

part 'localdb.g.dart';

@HiveType(typeId: 0)
class Details {
  @HiveField(0)
  late String image;

  Details({
    required this.image,
  });
}
