import 'dart:math';
abstract class Helpers {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }
}

