import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';

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
          HelperFunctions.showSnackBar(
            context,
            message: state.message,
            isError: true,
          );
        } else if (state is OwnerProfileLoaded && state.message != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.message!,
            isError: false,
          );
        } else if (state is LogoutSuccessful) {
          HelperFunctions.showSnackBar(
            context,
            message: StringConstants.logoutSuccessful,
            isError: false,
          );
          if (context.mounted) {
            context.go(RoutesConstants.loginRoute);
          }

          context.go(RoutesConstants.loginRoute);
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StringConstants.profile,
            style: TextStyle(
              color: ColorConstants.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: ColorConstants.scaffoldBg,
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

            final isUploading = state is OwnerProfileUploading;

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorConstants.scaffoldBg, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
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
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: ColorConstants.primaryLight
                                  .withAlpha(15),
                              backgroundImage: profile.imageUrl != null
                                  ? CachedNetworkImageProvider(
                                      profile.imageUrl!,
                                    )
                                  : null,
                              child: profile.imageUrl == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: ColorConstants.primary,
                                    )
                                  : null,
                            ),
                          ),
                          if (isUploading)
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withAlpha(30),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: ColorConstants.primary,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      profile.username,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatRole(profile.role),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorConstants.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 32),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(80),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                            color: Colors.black.withAlpha(5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(
                            Icons.email_outlined,
                            'Email',
                            profile.email,
                          ),
                          const Divider(height: 24),
                          _infoRow(
                            Icons.phone_outlined,
                            'Phone',
                            profile.phone.toString(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<OwnerProfileBloc>().add(LogoutEvent()),
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text(StringConstants.logout),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primary,
                        foregroundColor: ColorConstants.cardBg,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static String _formatRole(String role) {
    return role
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: ColorConstants.primaryLight, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
