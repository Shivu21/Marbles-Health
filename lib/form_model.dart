import 'package:flutter/material.dart';

class FormModel with ChangeNotifier {
  List<FormComponent> components = [FormComponent()];

  void addComponent() {
    components.add(FormComponent());
    notifyListeners();
  }

  void removeComponent(int index) {
    if (components.length > 1) {
      components.removeAt(index);
      notifyListeners();
    }
  }
}

class FormComponent {
  String label = '';
  String infoText = '';
  String settings = 'Required';
}
