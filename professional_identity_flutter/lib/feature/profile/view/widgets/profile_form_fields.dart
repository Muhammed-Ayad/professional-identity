import 'package:flutter/material.dart';

class ProfileBasicFields extends StatelessWidget {
  final TextEditingController handleController;
  final TextEditingController fullNameController;
  final TextEditingController headlineController;
  final TextEditingController currentRoleController;
  final TextEditingController yearsController;
  final bool enabled;

  const ProfileBasicFields({
    super.key,
    required this.handleController,
    required this.fullNameController,
    required this.headlineController,
    required this.currentRoleController,
    required this.yearsController,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: handleController,
                enabled: enabled,
                decoration: const InputDecoration(
                  labelText: 'Username *',
                  hintText: 'e.g. mohamed-ayad',
                  prefixText: '/u/',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Handle is required';
                  }
                  if (val.trim().length < 3) {
                    return 'At least 3 characters';
                  }
                  if (!RegExp(
                    r'^[a-z0-9_-]+$',
                  ).hasMatch(val.trim().toLowerCase())) {
                    return 'Lowercase letters, numbers, -, _';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: fullNameController,
                enabled: enabled,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'e.g. Mohamed Ayad',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: headlineController,
          enabled: enabled,
          decoration: const InputDecoration(
            labelText: 'Professional Headline',
            hintText: 'e.g. Senior Flutter & Cloud Architect',
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: currentRoleController,
                enabled: enabled,
                decoration: const InputDecoration(
                  labelText: 'Current Role / Specialization',
                  hintText: 'e.g. Full-Stack Lead',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: yearsController,
                enabled: enabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Years Exp',
                  hintText: 'e.g. 7',
                ),
                validator: (val) {
                  if (val != null && val.trim().isNotEmpty) {
                    if (int.tryParse(val.trim()) == null) {
                      return 'Invalid';
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileContactFields extends StatelessWidget {
  final TextEditingController locationController;
  final TextEditingController availabilityController;
  final TextEditingController contactEmailController;
  final TextEditingController websiteUrlController;
  final bool enabled;

  const ProfileContactFields({
    super.key,
    required this.locationController,
    required this.availabilityController,
    required this.contactEmailController,
    required this.websiteUrlController,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: locationController,
                enabled: enabled,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'e.g. Berlin, Germany',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: availabilityController,
                enabled: enabled,
                decoration: const InputDecoration(
                  labelText: 'Availability',
                  hintText: 'e.g. Available for hire',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: contactEmailController,
                enabled: enabled,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Public Contact Email',
                  hintText: 'hello@example.com',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: websiteUrlController,
                enabled: enabled,
                decoration: const InputDecoration(
                  labelText: 'Portfolio / Website URL',
                  hintText: 'https://example.com',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
