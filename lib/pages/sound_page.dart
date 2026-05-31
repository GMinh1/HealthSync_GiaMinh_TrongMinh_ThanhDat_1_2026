import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/shared_widgets.dart';

// ─────────────────────────── Data model ─────────────────────────────────
class _SoundData {
  final String title;
  final List<Color> gradient;
  final IconData icon;
  const _SoundData(this.title, this.gradient, this.icon);
}

// ─────────────────────────── Sound Page ─────────────────────────────────
class SoundPage extends StatefulWidget {
  const SoundPage({super.key});

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  int _cat = 0;

  static const _cats = ['🔥 Hot', '🎨 Colored Noises', '🌿 Nature', '☁️ Cloud'];

  static const _sounds = [
    _SoundData('Singing Bowl Sounds', [
      Color(0xFF1B5E3B),
      Color(0xFF4CAF80),
    ], Icons.self_improvement),
    _SoundData('Sound of Running Water', [
      Color(0xFF0D3B6E),
      Color(0xFF1976D2),
    ], Icons.water),
    _SoundData('Flowing Water in the Forest', [
      Color(0xFF1A4731),
      Color(0xFF43A047),
    ], Icons.forest),
    _SoundData('White Noise Snow', [
      Color(0xFF546E7A),
      Color(0xFF90A4AE),
    ], Icons.ac_unit),
    _SoundData('Thunderstorm', [
      Color(0xFF1A237E),
      Color(0xFF3949AB),
    ], Icons.thunderstorm),
    _SoundData('Mist Waterfall', [
      Color(0xFF006064),
      Color(0xFF00ACC1),
    ], Icons.waves),
    _SoundData('Tropical Night', [
      Color(0xFF1B0033),
      Color(0xFF4A148C),
    ], Icons.nightlight),
    _SoundData('Lotus Pond', [
      Color(0xFF1B3A2F),
      Color(0xFF66BB6A),
    ], Icons.local_florist),
  ];

  @override
  Widget build(BuildContext context) {
    return PageGradient(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle('Sleep Music'),
            // Category chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Row(
                children: List.generate(_cats.length, (i) {
                  final sel = i == _cat;
                  return GestureDetector(
                    onTap: () => setState(() => _cat = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? kGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: sel
                            ? [
                                const BoxShadow(
                                  color: Color(0x402DCB73),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        _cats[i],
                        style: TextStyle(
                          color: sel ? Colors.white : kSubText,
                          fontSize: 13,
                          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Grid nhạc
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.88,
                ),
                itemCount: _sounds.length,
                itemBuilder: (_, i) => _SoundCard(data: _sounds[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── Sound Card ─────────────────────────────────
class _SoundCard extends StatelessWidget {
  final _SoundData data;
  const _SoundCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: data.gradient,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Icon nền mờ
          Center(
            child: Icon(
              data.icon,
              size: 80,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
          // Label phía dưới
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: kGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.graphic_eq,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      data.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
