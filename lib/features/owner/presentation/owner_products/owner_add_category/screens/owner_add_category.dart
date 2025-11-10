import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_add_category/bloc/owner_add_category_bloc.dart';

class OwnerAddCategory extends StatelessWidget {
  const OwnerAddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OwnerAddCategoryBloc(di()),
      child: const _OwnerAddCategoryBody(),
    );
  }
}

class _OwnerAddCategoryBody extends StatefulWidget {
  const _OwnerAddCategoryBody();

  @override
  State<_OwnerAddCategoryBody> createState() => _OwnerAddCategoryBodyState();
}

class _OwnerAddCategoryBodyState extends State<_OwnerAddCategoryBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OwnerAddCategoryBloc, OwnerAddCategoryState>(
      listener: (context, state) {
        if (state is OwnerAddCategorySuccess) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          context.pop(true);
        }

        if (state is OwnerAddCategoryFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          title: const Text("Add Category"),
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? "Name cannot be empty"
                      : null,
                ),

                TextFormField(
                  controller: descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? "Description cannot be empty"
                      : null,
                ),

                const SizedBox(height: 10),

                BlocBuilder<OwnerAddCategoryBloc, OwnerAddCategoryState>(
                  builder: (context, state) {
                    if (state is OwnerAddCategoryLoading) {
                      return const CircularProgressIndicator();
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<OwnerAddCategoryBloc>().add(
                              AddCategoryRequested(
                                categoryName: nameController.text.trim(),
                                description: descController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
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
