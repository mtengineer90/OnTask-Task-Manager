
class CheckBox {
  String baslik;
  bool isChecked;

  CheckBox(this.baslik,this.isChecked);

  @override
  String toString() {
    return "[${this.baslik} (${this.isChecked ? "✔️" : "❌"})]";
  }
}