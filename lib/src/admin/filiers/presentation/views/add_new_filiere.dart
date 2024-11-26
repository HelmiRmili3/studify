import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';
import '../../../../../models/filiere.dart';

import '../bloc/filieres/filiere_bloc.dart';
import '../bloc/filieres/filiere_events.dart';
import '../bloc/filieres/filiere_states.dart';

class AddNewFiliere extends StatefulWidget {
  const AddNewFiliere({super.key});

  @override
  State<AddNewFiliere> createState() => _AddNewFiliereState();
}

class _AddNewFiliereState extends State<AddNewFiliere> {
  final TextEditingController filiereName = TextEditingController();
  final TextEditingController filiereCode = TextEditingController();
  final TextEditingController nbYears = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add New Filiere"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: BlocListener<FiliereBloc, FiliereState>(
            listener: (context, state) {
              if (state is FiliereAdded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Filiere added successfully!"),
                  ),
                );
                Navigator.pop(context);
              } else if (state is FiliereError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
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
                  controller: nbYears,
                ),
                const SizedBox(height: 20),
                BlocBuilder<FiliereBloc, FiliereState>(
                  builder: (context, state) {
                    if (state is FiliereAdding) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomElevatedButton(
                      onPressed: () {
                        final filiere = Filiere(
                          filiere: filiereName.text,
                          code: filiereCode.text,
                          nbYears: int.tryParse(nbYears.text) ?? 1,
                        );
                        context.read<FiliereBloc>().add(AddFiliere(filiere));
                      },
                      text: "Create",
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
