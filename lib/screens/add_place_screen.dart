import 'package:flutter/material.dart';
import 'package:great_places/screens/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Title'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ImageInput(),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                //height of 50 and width of infinity
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
