import 'package:flutter/material.dart';
import '../models/daily_polymer.dart';

final List<DailyPolymer> featuredPolymers = [
  DailyPolymer(
    name: 'Polietilen Tereftalat (PET)',
    description:
        'Termoplastik polyester ailesinin en yaygın üyesi. Şeffaf, dayanıklı ve geri dönüştürülebilir.',
    properties: ['Termoplastik', 'Şeffaf', 'Geri Dönüştürülebilir'],
    category: 'Termoplastik',
    color: Colors.blue,
  ),
  DailyPolymer(
    name: 'Polipropilen (PP)',
    description:
        'Yüksek kimyasal dirençli ve ısıya dayanıklı çok yönlü termoplastik.',
    properties: ['Hafif', 'Isıya Dayanıklı', 'Kimyasal Dirençli'],
    category: 'Termoplastik',
    color: Colors.green,
  ),
  DailyPolymer(
    name: 'Poliüretan (PU)',
    description:
        'Esnek yapısı ve yüksek dayanımı ile öne çıkan çok yönlü polimer.',
    properties: ['Esnek', 'Darbe Dayanımlı', 'İzolasyon'],
    category: 'Termoset',
    color: Colors.orange,
  ),
  DailyPolymer(
    name: 'Poliamid (PA)',
    description:
        'Yüksek mekanik dayanım ve aşınma direnci sunan mühendislik plastiği.',
    properties: ['Dayanıklı', 'Aşınma Dirençli', 'Isıya Dayanıklı'],
    category: 'Termoplastik',
    color: Colors.purple,
  ),
  DailyPolymer(
    name: 'Silikon (SI)',
    description:
        'Geniş sıcaklık aralığında kullanılabilen esnek ve dayanıklı elastomer.',
    properties: ['Elastik', 'Isı Dayanımı', 'Kimyasal Kararlı'],
    category: 'Elastomer',
    color: Colors.red,
  ),
];
