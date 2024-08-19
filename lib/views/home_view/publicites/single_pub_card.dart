import 'package:flutter/material.dart';
import 'package:new_digitalis_event_app/model/publicite_model.dart';
import 'package:new_digitalis_event_app/utils/constants/app_colors/app_colors.dart';

class SinglePubCard extends StatelessWidget {
  final PubliciteModel pubModel;

  const SinglePubCard({super.key, required this.pubModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D3E),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: kDeepPurpleColor,
                  blurRadius: 0,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35),
                  BlendMode.darken,
                ),
                child: Image.network(
                  pubModel.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 16,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                pubModel.name ?? '',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            left: 16,
            child: Row(
              children: [
                const Icon(Icons.description_outlined, size: 18),
                const SizedBox(width: 4),
                Text(
                  pubModel.description ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
