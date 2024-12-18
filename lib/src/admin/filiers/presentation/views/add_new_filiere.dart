import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/common/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/file_picker_helper.dart';
import '../../../../../models/matiere.dart';
import '../../../../../models/new_filiere.dart';
import '../../../../common/auth/presentation/widgets/custom_text_filed.dart';

import '../bloc/filieres/filiere_bloc.dart';
import '../bloc/filieres/filiere_events.dart';
import '../bloc/filieres/filiere_states.dart';

class AddNewFiliere extends StatefulWidget {
  const AddNewFiliere({super.key});

  @override
  State<AddNewFiliere> createState() => _AddNewFiliereState();
}

class _AddNewFiliereState extends State<AddNewFiliere> {
  FileEntity? _selectedImage;
  final TextEditingController filiereName = TextEditingController();
  final TextEditingController filiereCode = TextEditingController();
  final TextEditingController nbYears = TextEditingController();

  @override
  void dispose() {
    filiereCode.dispose();
    filiereName.dispose();
    nbYears.dispose();
    super.dispose();
  }

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
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 65.h),
                height: 600.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -50.h,
                      child: GestureDetector(
                        onTap: () async {
                          FileEntity? image =
                              await FilePickerHelper.pickImage();
                          if (image != null) {
                            setState(() {
                              _selectedImage = image;
                            });
                          }
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 120.h,
                                height: 120.h,
                                padding: EdgeInsets.all(4.h),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: _selectedImage == null
                                        ? const AssetImage(
                                            'assets/images/placeholder.png',
                                          )
                                        : FileImage(
                                            File(
                                              _selectedImage!.filepath,
                                            ),
                                          ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 3.w,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8.h,
                                right: 8.w,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            hintText: 'Filiere',
                            controller: filiereName,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Code',
                            controller: filiereCode,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Number of years',
                            controller: nbYears,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
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
                                  final filiere = NewFiliere(
                                    filiere: filiereName.text,
                                    code: filiereCode.text.toUpperCase(),
                                    nbYears: int.tryParse(nbYears.text) ?? 1,
                                    image: '',
                                  );
                                  context.read<FiliereBloc>().add(AddFiliere(
                                      filiere, File(_selectedImage!.filepath)));
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
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
