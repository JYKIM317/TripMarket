import 'package:image_picker/image_picker.dart';

class LocalGarllery {
  Future<XFile?> getImageFromGarllery() async {
    final ImagePicker picker = ImagePicker();

    return await picker.pickImage(source: ImageSource.gallery);
  }
}
