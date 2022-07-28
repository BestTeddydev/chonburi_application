import 'dart:math';

randomList(List<dynamic> datas) {
  final random = Random();
  List<dynamic> randoms = [];
  List<int> usagedIndex = [];
  while (randoms.length < datas.length) {
    int indexRandom = random.nextInt(datas.length);
    bool used = usagedIndex.contains(indexRandom);
    if (!used) {
      randoms.add(datas[indexRandom]);
      usagedIndex.add(indexRandom);
    }
  }
  return randoms;
}
