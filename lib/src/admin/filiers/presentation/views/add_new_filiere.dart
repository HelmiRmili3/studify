import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';
import '../widgets/email_text_filed.dart';

class AddNewFiliere extends StatefulWidget {
  const AddNewFiliere({super.key});

  @override
  State<AddNewFiliere> createState() => _AddNewFiliereState();
}

class _AddNewFiliereState extends State<AddNewFiliere> {
  TextEditingController filiereName = TextEditingController();
  TextEditingController filiereCode = TextEditingController();
  TextEditingController nbYears = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Add New Filiere"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                hintText: 'Filiere',
                controller: filiereName,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Code',
                controller: filiereCode,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Number of years',
                controller: filiereCode,
              ),
              const SizedBox(height: 20),
              EmailTextField(
                controller: filiereCode,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {},
                text: "Create",
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ],
          )),
        ));
  }
}
