import '../models/polymer_fact.dart';

// Bilgileri ayrı bir dosyada tutalım
final List<PolymerFact> polymerFacts = [
  PolymerFact(
    fact:
        'PET şişeler geri dönüştürüldüğünde polyester elyaf haline getirilebilir '
        've tekstil ürünlerinde kullanılabilir. Bir adet PET şişeden yaklaşık '
        '6 adet T-shirt üretilebilir.',
    source: 'National Geographic, 2019',
    sourceUrl:
        'https://www.nationalgeographic.com/environment/article/plastic-bottles',
  ),
  PolymerFact(
    fact:
        'Dünya\'da yıllık plastik üretimi 400 milyon tonu aşmıştır. Bu üretimin '
        'yaklaşık %40\'ı ambalaj malzemelerinde kullanılmaktadır.',
    source: 'PlasticsEurope, 2023',
    sourceUrl:
        'https://plasticseurope.org/knowledge-hub/plastics-the-facts-2023/',
  ),
  PolymerFact(
    fact:
        'Naylon, II. Dünya Savaşı sırasında paraşüt ipliği olarak kullanılmak üzere '
        'geliştirilmiş ve daha sonra günlük hayatımıza girmiştir.',
    source: 'American Chemical Society',
    sourceUrl:
        'https://www.acs.org/education/whatischemistry/landmarks/nylon.html',
  ),
  PolymerFact(
    fact:
        'PTFE (Teflon), -200°C ile +260°C arasında kullanılabilen ve bilinen en düşük '
        'sürtünme katsayısına sahip polimerlerden biridir.',
    source: 'Journal of Materials Science, 2020',
  ),
  PolymerFact(
    fact:
        'Kevlar, çelikten 5 kat daha güçlü olmasına rağmen çok daha hafiftir. '
        'Bu özelliği sayesinde kurşungeçirmez yeleklerde kullanılır.',
    source: 'DuPont Technical Guide',
    sourceUrl: 'https://www.dupont.com/kevlar.html',
  ),
];
