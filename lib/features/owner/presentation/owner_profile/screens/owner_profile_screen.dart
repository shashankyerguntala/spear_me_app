import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/owner/presentation/owner_profile/bloc/owner_profile_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_profile/screens/owner_profile_shimmer.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerProfileBloc>()..add(FetchOwnerProfile()),
      child: const _OwnerProfileBody(),
    );
  }
}

class _OwnerProfileBody extends StatelessWidget {
  const _OwnerProfileBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OwnerProfileBloc, OwnerProfileState>(
      listener: (context, state) {
        if (state is OwnerProfileFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state is OwnerProfileLoaded && state.message != null) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message!),
                backgroundColor: ColorConstants.success,
              ),
            );
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<OwnerProfileBloc, OwnerProfileState>(
          builder: (context, state) {
            if (state is OwnerProfileLoading) {
              return const OwnerProfileShimmer();
            }

            final profile = state is OwnerProfileLoaded
                ? state.profile
                : state is OwnerProfileUploading
                ? state.profile
                : null;

            if (profile == null) {
              return const SizedBox.shrink();
            }

            final bool isUploading = state is OwnerProfileUploading;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final image = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 70,
                      );
                      if (image != null && context.mounted) {
                        context.read<OwnerProfileBloc>().add(
                          UpdateProfileImage(image.path),
                        );
                      }
                    },

                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: profile.imageUrl != null
                              ? CachedNetworkImageProvider(profile.imageUrl!)
                              : null,
                          child: profile.imageUrl == null
                              ? const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        //! style from
                        if (isUploading)
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withAlpha(35),
                            ),
                            child: CircularProgressIndicator(
                              strokeWidth: 8,
                              color: Colors.white,
                            ),
                          ),

                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: ColorConstants.primary,
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    profile.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    profile.role
                        .replaceAll("_", " ")
                        .toLowerCase()
                        .split(" ")
                        .map((w) => w[0].toUpperCase() + w.substring(1))
                        .join(" "),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorConstants.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.black.withAlpha(5),
                        ),
                      ],
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        _profileRow("Email", profile.email),
                        _profileRow("Phone", profile.phone.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _profileRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      Text(value, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
    ],
  );
}
