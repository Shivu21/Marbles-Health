import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final formModel = context.read<FormModel>();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Form Data'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: formModel.components
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          FormComponent component = entry.value;
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Component ${index + 1}:'),
                                  Text('Label: ${component.label}'),
                                  Text('Info-Text: ${component.infoText}'),
                                  Text('Settings: ${component.settings}'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: Consumer<FormModel>(
        builder: (context, formModel, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              ...formModel.components.asMap().entries.map((entry) {
                int index = entry.key;
                FormComponent component = entry.value;
                return DynamicFormComponent(
                  key: ValueKey(index),
                  component: component,
                  onRemove: () => formModel.removeComponent(index),
                );
              }),
              ElevatedButton(
                onPressed: formModel.addComponent,
                child: Text('ADD'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DynamicFormComponent extends StatelessWidget {
  final FormComponent component;
  final VoidCallback onRemove;

  const DynamicFormComponent({
    Key? key,
    required this.component,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Label'),
              onChanged: (value) => component.label = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Info-Text'),
              onChanged: (value) => component.infoText = value,
            ),
            DropdownButton<String>(
              value: component.settings,
              items: ['Required', 'Readonly'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  component.settings = value;
                }
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
