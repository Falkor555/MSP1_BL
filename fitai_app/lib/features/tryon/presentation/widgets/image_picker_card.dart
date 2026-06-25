import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImagePickerCard extends StatelessWidget {
  final String title;
  final File? imageFile;
  final Function(File) onImageSelected;

  const ImagePickerCard({
    super.key,
    required this.title,
    required this.imageFile,
    required this.onImageSelected,
  });

  // Méthode pour appeler la galerie ou l'appareil photo
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1024, // Limite la résolution pour alléger l'upload vers Django
      );

      if (pickedFile != null) {
        // Renvoie le fichier sélectionné au parent
        onImageSelected(File(pickedFile.path));
      }
    } catch (e) {
      // Gestion basique si l'utilisateur refuse les permissions
      debugPrint("Erreur lors de la sélection de l'image : $e");
    }
    
    // Ferme le BottomSheet si l'interface est toujours affichée
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  // Affiche le menu du bas avec les deux choix
  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () => _pickImage(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Appareil photo'),
                onTap: () => _pickImage(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Le titre au-dessus de la carte (ex: "Photo de la personne")
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        
        // La zone cliquable
        GestureDetector(
          onTap: () => _showPickerOptions(context),
          child: Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            // Affichage conditionnel : Image ou Placeholder
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb 
                        // Sur le Web, ImagePicker renvoie une URL blob temporaire
                        ? Image.network(imageFile!.path, fit: BoxFit.cover) 
                        // Sur mobile, on lit le fichier physique
                        : Image.file(imageFile!, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text(
                        'Appuyez pour sélectionner',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}