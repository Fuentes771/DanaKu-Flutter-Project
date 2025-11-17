import 'package:flutter/material.dart';
import 'dart:io';

/// Reusable profile avatar widget with support for:
/// - Network images
/// - Local file images
/// - Fallback to initials
/// - Edit button overlay
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final String? name;
  final double radius;
  final VoidCallback? onEdit;
  final bool showEditButton;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.name,
    this.radius = 50,
    this.onEdit,
    this.showEditButton = false,
  });

  String _getInitials() {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return '${parts[0].substring(0, 1)}${parts[1].substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget avatarContent;

    if (imageFile != null) {
      // Display local file image
      avatarContent = CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(imageFile!),
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      // Display network image
      avatarContent = CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        onBackgroundImageError: (_, __) {},
        child: const SizedBox(),
      );
    } else {
      // Display initials fallback
      avatarContent = CircleAvatar(
        radius: radius,
        backgroundColor: cs.primaryContainer,
        child: Text(
          _getInitials(),
          style: TextStyle(
            fontSize: radius * 0.6,
            fontWeight: FontWeight.bold,
            color: cs.onPrimaryContainer,
          ),
        ),
      );
    }

    if (!showEditButton || onEdit == null) {
      return avatarContent;
    }

    // Add edit button overlay
    return Stack(
      children: [
        avatarContent,
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: cs.primary,
              shape: BoxShape.circle,
              border: Border.all(color: cs.surface, width: 2),
            ),
            child: IconButton(
              icon: Icon(Icons.edit, size: radius * 0.4, color: cs.onPrimary),
              onPressed: onEdit,
              padding: EdgeInsets.all(radius * 0.15),
              constraints: const BoxConstraints(),
            ),
          ),
        ),
      ],
    );
  }
}
