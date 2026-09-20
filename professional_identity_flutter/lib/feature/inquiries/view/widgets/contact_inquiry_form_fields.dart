import 'package:flutter/material.dart';

class ContactInquiryFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final TextEditingController honeypotController;
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const ContactInquiryFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.honeypotController,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Invisible honeypot field for bot deterrence
        Offstage(
          offstage: true,
          child: TextFormField(
            controller: honeypotController,
            decoration: const InputDecoration(labelText: 'Leave empty'),
          ),
        ),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Your Name *',
            hintText: 'e.g. Jane Smith',
            prefixIcon: Icon(Icons.person_outline, size: 20),
          ),
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter your name.';
            }
            if (val.trim().length > 100) {
              return 'Name cannot exceed 100 characters.';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Your Email *',
            hintText: 'jane@example.com',
            prefixIcon: Icon(Icons.email_outlined, size: 20),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter your email.';
            }
            if (!val.contains('@') || !val.contains('.')) {
              return 'Please enter a valid email address.';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: selectedType,
          decoration: const InputDecoration(
            labelText: 'Inquiry Category',
            prefixIcon: Icon(Icons.category_outlined, size: 20),
          ),
          items: const [
            DropdownMenuItem(
              value: 'job_offer',
              child: Text('Job Offer / Hiring'),
            ),
            DropdownMenuItem(
              value: 'freelance',
              child: Text('Freelance / Contract'),
            ),
            DropdownMenuItem(
              value: 'collaboration',
              child: Text('Collaboration'),
            ),
            DropdownMenuItem(
              value: 'speaking',
              child: Text('Speaking / Mentorship'),
            ),
            DropdownMenuItem(value: 'general', child: Text('General Inquiry')),
          ],
          onChanged: (val) {
            if (val != null) onTypeChanged(val);
          },
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: subjectController,
          decoration: const InputDecoration(
            labelText: 'Subject *',
            hintText: 'e.g. Senior Flutter Role at Acme Corp',
            prefixIcon: Icon(Icons.subject_rounded, size: 20),
          ),
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter a subject.';
            }
            if (val.trim().length > 150) {
              return 'Subject cannot exceed 150 characters.';
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: messageController,
          decoration: const InputDecoration(
            labelText: 'Message *',
            hintText: 'Describe your proposal or question in detail...',
            alignLabelWithHint: true,
          ),
          maxLines: 4,
          maxLength: 3000,
          textInputAction: TextInputAction.newline,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Please enter your message.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
