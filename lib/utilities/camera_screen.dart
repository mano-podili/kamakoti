import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // For accessing directories
import 'package:path/path.dart'; // For handling file paths

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _savedImagePath;
  int _imageCount = 0;

  @override
  void initState() {
    super.initState();
    _loadImageCount();
  }

  // Load the current image count from storage
  Future<void> _loadImageCount() async {
    final Directory saveDir = await _getSaveDirectory();
    if (await saveDir.exists()) {
      final List<FileSystemEntity> files = saveDir.listSync();
      setState(() {
        _imageCount = files.where((file) => file is File).length;
      });
    }
  }

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo == null) return;

    final Directory saveDir = await _getSaveDirectory();
    final String imageName = '${_imageCount.toString().padLeft(3, '0')}.jpg'; // e.g., 001.jpg, 002.jpg
    final String localImagePath = '${saveDir.path}/$imageName';

    final File localImage = await File(photo.path).copy(localImagePath);

    setState(() {
      _image = photo;
      _savedImagePath = localImage.path;
      _imageCount++;
    });

    print('Image saved to: $localImagePath');
  }

  // Helper function to get the desired save directory
  Future<Directory> _getSaveDirectory() async {
    final Directory? dcimDir = await getExternalStorageDirectory();
    final Directory saveDir = Directory('${dcimDir!.path}/kamakoti');
    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }
    return saveDir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CAMERA')),
      body: Column(
        children: [
          _image == null
              ? const Text('No image captured.')
              : Image.file(File(_image!.path)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _takePicture,
            child: const Text('Keep scanning'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_savedImagePath != null) {
                Navigator.pop(context, _savedImagePath); // Return image path
              } else {
                print('No image to submit');
                Navigator.pop(context); // Return to Scraper screen
              }
            },
            child: const Text('Submit'),
          ),
          if (_savedImagePath != null)
            Text('Image saved at: $_savedImagePath', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
