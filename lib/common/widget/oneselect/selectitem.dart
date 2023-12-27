/// A model class used to represent a selectable item.
class SelectItem<T> {
  final T value;
  final String label;
  bool selected = false;

  SelectItem(this.value, this.label);
}
