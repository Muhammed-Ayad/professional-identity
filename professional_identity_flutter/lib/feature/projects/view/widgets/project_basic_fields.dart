import 'package:flutter/material.dart';

class ProjectBasicFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController roleController;
  final TextEditingController descriptionController;
  final TextEditingController urlController;
  final TextEditingController repoUrlController;

  const ProjectBasicFields({
    super.key,
    required this.titleController,
    required this.roleController,
    required this.descriptionController,
    required this.urlController,
    required this.repoUrlController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Project Title *',
            hintText: 'e.g. Serverpod Digital Platform',
            prefixIcon: Icon(Icons.folder_special_outlined),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Project title is required';
            }
            if (val.trim().length > 100) {
              return 'Title must be 100 characters or less';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: roleController,
          decoration: const InputDecoration(
            labelText: 'Your Role',
            hintText: 'e.g. Full-Stack Lead / Creator',
            prefixIcon: Icon(Icons.badge_outlined),
          ),
          validator: (val) {
            if (val != null && val.trim().length > 100) {
              return 'Role must be 100 characters or less';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Key features, architecture, and impact...',
            alignLabelWithHint: true,
          ),
          validator: (val) {
            if (val != null && val.trim().length > 2000) {
              return 'Description must be 2000 characters or less';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: urlController,
          decoration: const InputDecoration(
            labelText: 'Project Live Demo URL',
            hintText: 'https://example.com/demo',
            prefixIcon: Icon(Icons.language_rounded),
          ),
          validator: (val) {
            if (val != null && val.trim().isNotEmpty) {
              final uri = Uri.tryParse(val.trim());
              if (uri == null ||
                  (!uri.hasScheme ||
                      (uri.scheme != 'http' && uri.scheme != 'https')) ||
                  uri.host.isEmpty) {
                return 'Must be a valid URL starting with http:// or https://';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: repoUrlController,
          decoration: const InputDecoration(
            labelText: 'Repository URL',
            hintText: 'https://github.com/username/project',
            prefixIcon: Icon(Icons.code_rounded),
          ),
          validator: (val) {
            if (val != null && val.trim().isNotEmpty) {
              final uri = Uri.tryParse(val.trim());
              if (uri == null ||
                  (!uri.hasScheme ||
                      (uri.scheme != 'http' && uri.scheme != 'https')) ||
                  uri.host.isEmpty) {
                return 'Must be a valid URL starting with http:// or https://';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
