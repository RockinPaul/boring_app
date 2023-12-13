extension StringExtension on String {
  String capitalizeActivityType() {
    if (isEmpty) {
      return this;
    }
    if (this == 'diy') {
      return 'DIY';
    }
    if (this == 'busywork') {
      return 'Work';
    }
    return this[0].toUpperCase() + substring(1);
  }
}
