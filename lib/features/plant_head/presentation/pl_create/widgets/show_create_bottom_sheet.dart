import 'package:flutter/material.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/widgets/custom_textfield.dart';

Future<void> showCreateBottomSheet(
  BuildContext context, {
  required String title,
  required List<TextEditingController> controllers,
  required List<String> labels,
  required VoidCallback onSubmit,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          ...List.generate(labels.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: CustomTextField(
                controller: controllers[i],
                label: labels[i],
                validatorMsg: "${labels[i]} cannot be empty",
                isNumber: false,
              ),
            );
          }),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    ),
  );
}
