import 'package:flutter/material.dart';

/// Orchard illustration visual banner as shown in the approved reference image.
class OrchardVisual extends StatelessWidget {
  const OrchardVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: AspectRatio(
          aspectRatio: 2.1,
          child: Image.asset(
            'assets/images/orchard_banner_2x.png',
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              // Graceful fallback if image is loading or unavailable
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xD4E8D6FF),
                      const Color(0x6681C784),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    '🌳🍊',
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
