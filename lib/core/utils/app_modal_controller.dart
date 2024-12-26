import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ModalController {

  void showModal(BuildContext context, Widget modalContent,{bool isDismissible = true}) {

    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: isDismissible,
      context: context,
      builder: (BuildContext context) => modalContent,
    );
  }

  void closeModal(BuildContext context) {
    Navigator.pop(context);
  }

}