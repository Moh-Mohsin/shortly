import 'package:shortly/gen/assets.gen.dart';

class Benefit {
  final String title;
  final String description;
  final String imageAsset;

  Benefit(this.title, this.description, this.imageAsset);

  static List<Benefit> getAll() {
    return [
      Benefit(
        "Brand Recognition",
        "Boost your brand recognition\n"
            "with each click. Generic links\n"
            "don't mean a thin. Branded\n"
            "links help instil confidence in\n"
            " your content",
        Assets.images.diagram,
      ),
      Benefit(
        "Detailed Records",
        "Gain insights into who is clicking\n"
            "your links. Knowing when and\n"
            "where people engage with your\n"
            "content helps inform better\n"
            "decisions.",
        Assets.images.gauge,
      ),
      Benefit(
        "Fully Customizable",
        "Improve brand awareness and\n"
            "content discoverability through\n"
            "customizable links,\n"
            "supercharging audience\n"
            "engagement",
        Assets.images.tools,
      ),
    ];
  }
}
