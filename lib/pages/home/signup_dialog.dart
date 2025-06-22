import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF131313),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => SmartDialog.dismiss(),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
              children: [
                const TextSpan(text: 'Already have an account? '),
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(color: Color(0xFF4ADE80)),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    // TODO: Implement Log In navigation
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Email', style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          _buildTextField(hintText: 'Enter Email'),
          const SizedBox(height: 16),
          _buildTextField(hintText: 'Invite Code (Optional)'),
          const SizedBox(height: 8),
          Text(
            'The invite code cannot be changed after binding. Please ensure the correct invite code is entered.',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4ADE80),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[800])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('OR Sign Up', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ),
              Expanded(child: Divider(color: Colors.grey[800])),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(icon: Icons.telegram, label: 'Telegram'),
              const SizedBox(width: 48),
              _buildSocialButton(icon: Icons.flutter_dash, label: 'Phantom'), // Placeholder
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Terms of Service', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('|', style: TextStyle(color: Colors.grey[500])),
              ),
              Text('Privacy Policy', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String hintText}) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4ADE80)),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String label}) {
    // Note: The Phantom icon is a placeholder. You might need to use a custom image/icon pack.
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[800]!)
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
} 