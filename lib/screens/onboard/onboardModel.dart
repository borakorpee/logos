// ignore_for_file: file_names, constant_identifier_names

class OnboardModel {
  final String title;
  final String image;
  final String description;

  const OnboardModel({
    required this.title,
    required this.image,
    required this.description,
  });
}

const OnboardData = [
  OnboardModel(
    title: "Özel Destek",
    image: "assets/onboard/image_1.png",
    description:
        "Uygulama veya web sitesi gibi bir dijital ortamla etkileşim kurmasını sağlayan bir tasarım özelliği.",
  ),
  OnboardModel(
    title: "Seçim Hakkı",
    image: "assets/onboard/image_2.png",
    description: "Durumuna göre en uygun Psikiyatri uzmanı ile görüşme imkanı.",
  ),
  OnboardModel(
    title: "Görüntülü Görüşme",
    image: "assets/onboard/image_3.png",
    description: "Görüntülü görüşme ile destek sağlama imkanı.",
  ),
];
