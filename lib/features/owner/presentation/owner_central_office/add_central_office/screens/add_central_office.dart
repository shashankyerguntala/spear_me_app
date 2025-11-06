import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/widgets/custom_form.dart';

class AddCentralOffice extends StatelessWidget {
  const AddCentralOffice({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            StringConstants.addFactory,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: <Widget>[
                CustomForm(
                  label: StringConstants.centralOfficeName,
                  controller: nameController,
                  validatorMsg: StringConstants.centralOfficeNameCannnotBeEmpty,
                ),
                CustomForm(
                  label: StringConstants.centralOfficeLocation,
                  controller: nameController,
                  validatorMsg: StringConstants.centralOfficeNameCannnotBeEmpty,
                ),
                CustomForm(
                  label: StringConstants.centralOfficeHead,
                  controller: nameController,
                  validatorMsg: StringConstants.centralOfficeNameCannnotBeEmpty,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primary,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Text(
                      StringConstants.createFactory,
                      style: TextStyle(color: ColorConstants.scaffoldBg),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
