extension StringExt on String? {
  String get orEmpty => this ?? '';

  String capitalise() {
    if (this == null || this!.isEmpty) return '';
    return this![0].toUpperCase() + this!.substring(1);
  }

  String capitalizeEachWord() {
    if (this == null || this!.isEmpty) return '';
    return this!.split(' ').map((word) => word.capitalise()).join(' ');
  }
}
