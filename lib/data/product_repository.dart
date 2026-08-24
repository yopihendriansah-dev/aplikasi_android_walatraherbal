import '../models/product.dart';

class ProductRepository {
  static const List<Product> products = [
    Product(
      id: 'p001',
      name: 'Essence Mascara Lash Princess',
      category: 'Kecantikan',
      price: 160000,
      description:
          'Essence Mascara Lash Princess adalah produk kategori Kecantikan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp',
      rating: 4.7,
      reviewCount: 52,
      soldCount: 34,
    ),
    Product(
      id: 'p002',
      name: 'Eyeshadow Palette with Mirror',
      category: 'Kecantikan',
      price: 320000,
      description:
          'Eyeshadow Palette with Mirror adalah produk kategori Kecantikan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/thumbnail.webp',
      rating: 4.4,
      reviewCount: 89,
      soldCount: 63,
    ),
    Product(
      id: 'p003',
      name: 'Powder Canister',
      category: 'Kecantikan',
      price: 240000,
      description:
          'Powder Canister adalah produk kategori Kecantikan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/beauty/powder-canister/thumbnail.webp',
      rating: 4.1,
      reviewCount: 126,
      soldCount: 92,
    ),
    Product(
      id: 'p004',
      name: 'Red Lipstick',
      category: 'Kecantikan',
      price: 208000,
      description:
          'Red Lipstick adalah produk kategori Kecantikan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/beauty/red-lipstick/thumbnail.webp',
      rating: 4.8,
      reviewCount: 163,
      soldCount: 121,
    ),
    Product(
      id: 'p005',
      name: 'Red Nail Polish',
      category: 'Kecantikan',
      price: 144000,
      description:
          'Red Nail Polish adalah produk kategori Kecantikan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/thumbnail.webp',
      rating: 4.5,
      reviewCount: 200,
      soldCount: 150,
    ),
    Product(
      id: 'p006',
      name: 'Calvin Klein CK One',
      category: 'Parfum',
      price: 800000,
      description:
          'Calvin Klein CK One adalah produk kategori Parfum untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/thumbnail.webp',
      rating: 4.2,
      reviewCount: 237,
      soldCount: 179,
    ),
    Product(
      id: 'p007',
      name: 'Chanel Coco Noir Eau De',
      category: 'Parfum',
      price: 2080000,
      description:
          'Chanel Coco Noir Eau De adalah produk kategori Parfum untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/fragrances/chanel-coco-noir-eau-de/thumbnail.webp',
      rating: 4.9,
      reviewCount: 274,
      soldCount: 208,
    ),
    Product(
      id: 'p008',
      name: 'Dior J\'adore',
      category: 'Parfum',
      price: 1440000,
      description:
          'Dior J\'adore adalah produk kategori Parfum untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/fragrances/dior-j\'adore/thumbnail.webp',
      rating: 4.6,
      reviewCount: 311,
      soldCount: 237,
    ),
    Product(
      id: 'p009',
      name: 'Dolce Shine Eau de',
      category: 'Parfum',
      price: 1120000,
      description:
          'Dolce Shine Eau de adalah produk kategori Parfum untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/thumbnail.webp',
      rating: 4.3,
      reviewCount: 348,
      soldCount: 266,
    ),
    Product(
      id: 'p010',
      name: 'Gucci Bloom Eau de',
      category: 'Parfum',
      price: 1280000,
      description:
          'Gucci Bloom Eau de adalah produk kategori Parfum untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/thumbnail.webp',
      rating: 4.0,
      reviewCount: 385,
      soldCount: 295,
    ),
    Product(
      id: 'p011',
      name: 'Annibale Colombo Bed',
      category: 'Furnitur',
      price: 30400000,
      description:
          'Annibale Colombo Bed adalah produk kategori Furnitur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/thumbnail.webp',
      rating: 4.7,
      reviewCount: 422,
      soldCount: 324,
    ),
    Product(
      id: 'p012',
      name: 'Annibale Colombo Sofa',
      category: 'Furnitur',
      price: 40000000,
      description:
          'Annibale Colombo Sofa adalah produk kategori Furnitur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-sofa/thumbnail.webp',
      rating: 4.4,
      reviewCount: 459,
      soldCount: 353,
    ),
    Product(
      id: 'p013',
      name: 'Bedside Table African Cherry',
      category: 'Furnitur',
      price: 4800000,
      description:
          'Bedside Table African Cherry adalah produk kategori Furnitur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/furniture/bedside-table-african-cherry/thumbnail.webp',
      rating: 4.1,
      reviewCount: 496,
      soldCount: 382,
    ),
    Product(
      id: 'p014',
      name: 'Knoll Saarinen Executive Conference Chair',
      category: 'Furnitur',
      price: 8000000,
      description:
          'Knoll Saarinen Executive Conference Chair adalah produk kategori Furnitur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/furniture/knoll-saarinen-executive-conference-chair/thumbnail.webp',
      rating: 4.8,
      reviewCount: 533,
      soldCount: 411,
    ),
    Product(
      id: 'p015',
      name: 'Wooden Bathroom Sink With Mirror',
      category: 'Furnitur',
      price: 12800000,
      description:
          'Wooden Bathroom Sink With Mirror adalah produk kategori Furnitur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/furniture/wooden-bathroom-sink-with-mirror/thumbnail.webp',
      rating: 4.5,
      reviewCount: 570,
      soldCount: 440,
    ),
    Product(
      id: 'p016',
      name: 'Apple',
      category: 'Bahan Makanan',
      price: 32000,
      description:
          'Apple adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/apple/thumbnail.webp',
      rating: 4.2,
      reviewCount: 607,
      soldCount: 469,
    ),
    Product(
      id: 'p017',
      name: 'Beef Steak',
      category: 'Bahan Makanan',
      price: 208000,
      description:
          'Beef Steak adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/beef-steak/thumbnail.webp',
      rating: 4.9,
      reviewCount: 644,
      soldCount: 498,
    ),
    Product(
      id: 'p018',
      name: 'Cat Food',
      category: 'Bahan Makanan',
      price: 144000,
      description:
          'Cat Food adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/cat-food/thumbnail.webp',
      rating: 4.6,
      reviewCount: 681,
      soldCount: 31,
    ),
    Product(
      id: 'p019',
      name: 'Chicken Meat',
      category: 'Bahan Makanan',
      price: 160000,
      description:
          'Chicken Meat adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/chicken-meat/thumbnail.webp',
      rating: 4.3,
      reviewCount: 718,
      soldCount: 60,
    ),
    Product(
      id: 'p020',
      name: 'Cooking Oil',
      category: 'Bahan Makanan',
      price: 80000,
      description:
          'Cooking Oil adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/cooking-oil/thumbnail.webp',
      rating: 4.0,
      reviewCount: 755,
      soldCount: 89,
    ),
    Product(
      id: 'p021',
      name: 'Cucumber',
      category: 'Bahan Makanan',
      price: 24000,
      description:
          'Cucumber adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/cucumber/thumbnail.webp',
      rating: 4.7,
      reviewCount: 792,
      soldCount: 118,
    ),
    Product(
      id: 'p022',
      name: 'Dog Food',
      category: 'Bahan Makanan',
      price: 176000,
      description:
          'Dog Food adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/dog-food/thumbnail.webp',
      rating: 4.4,
      reviewCount: 829,
      soldCount: 147,
    ),
    Product(
      id: 'p023',
      name: 'Eggs',
      category: 'Bahan Makanan',
      price: 48000,
      description:
          'Eggs adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/eggs/thumbnail.webp',
      rating: 4.1,
      reviewCount: 866,
      soldCount: 176,
    ),
    Product(
      id: 'p024',
      name: 'Fish Steak',
      category: 'Bahan Makanan',
      price: 240000,
      description:
          'Fish Steak adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/fish-steak/thumbnail.webp',
      rating: 4.8,
      reviewCount: 903,
      soldCount: 205,
    ),
    Product(
      id: 'p025',
      name: 'Green Bell Pepper',
      category: 'Bahan Makanan',
      price: 21000,
      description:
          'Green Bell Pepper adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/green-bell-pepper/thumbnail.webp',
      rating: 4.5,
      reviewCount: 940,
      soldCount: 234,
    ),
    Product(
      id: 'p026',
      name: 'Green Chili Pepper',
      category: 'Bahan Makanan',
      price: 16000,
      description:
          'Green Chili Pepper adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/green-chili-pepper/thumbnail.webp',
      rating: 4.2,
      reviewCount: 977,
      soldCount: 263,
    ),
    Product(
      id: 'p027',
      name: 'Honey Jar',
      category: 'Bahan Makanan',
      price: 112000,
      description:
          'Honey Jar adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/honey-jar/thumbnail.webp',
      rating: 4.9,
      reviewCount: 29,
      soldCount: 292,
    ),
    Product(
      id: 'p028',
      name: 'Ice Cream',
      category: 'Bahan Makanan',
      price: 88000,
      description:
          'Ice Cream adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/ice-cream/thumbnail.webp',
      rating: 4.6,
      reviewCount: 66,
      soldCount: 321,
    ),
    Product(
      id: 'p029',
      name: 'Juice',
      category: 'Bahan Makanan',
      price: 64000,
      description:
          'Juice adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/juice/thumbnail.webp',
      rating: 4.3,
      reviewCount: 103,
      soldCount: 350,
    ),
    Product(
      id: 'p030',
      name: 'Kiwi',
      category: 'Bahan Makanan',
      price: 40000,
      description:
          'Kiwi adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/kiwi/thumbnail.webp',
      rating: 4.0,
      reviewCount: 140,
      soldCount: 379,
    ),
    Product(
      id: 'p031',
      name: 'Lemon',
      category: 'Bahan Makanan',
      price: 15000,
      description:
          'Lemon adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/lemon/thumbnail.webp',
      rating: 4.7,
      reviewCount: 177,
      soldCount: 408,
    ),
    Product(
      id: 'p032',
      name: 'Milk',
      category: 'Bahan Makanan',
      price: 56000,
      description:
          'Milk adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/milk/thumbnail.webp',
      rating: 4.4,
      reviewCount: 214,
      soldCount: 437,
    ),
    Product(
      id: 'p033',
      name: 'Mulberry',
      category: 'Bahan Makanan',
      price: 80000,
      description:
          'Mulberry adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/mulberry/thumbnail.webp',
      rating: 4.1,
      reviewCount: 251,
      soldCount: 466,
    ),
    Product(
      id: 'p034',
      name: 'Nescafe Coffee',
      category: 'Bahan Makanan',
      price: 128000,
      description:
          'Nescafe Coffee adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/nescafe-coffee/thumbnail.webp',
      rating: 4.8,
      reviewCount: 288,
      soldCount: 495,
    ),
    Product(
      id: 'p035',
      name: 'Potatoes',
      category: 'Bahan Makanan',
      price: 37000,
      description:
          'Potatoes adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/potatoes/thumbnail.webp',
      rating: 4.5,
      reviewCount: 325,
      soldCount: 28,
    ),
    Product(
      id: 'p036',
      name: 'Protein Powder',
      category: 'Bahan Makanan',
      price: 320000,
      description:
          'Protein Powder adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/protein-powder/thumbnail.webp',
      rating: 4.2,
      reviewCount: 362,
      soldCount: 57,
    ),
    Product(
      id: 'p037',
      name: 'Red Onions',
      category: 'Bahan Makanan',
      price: 32000,
      description:
          'Red Onions adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/red-onions/thumbnail.webp',
      rating: 4.9,
      reviewCount: 399,
      soldCount: 86,
    ),
    Product(
      id: 'p038',
      name: 'Rice',
      category: 'Bahan Makanan',
      price: 96000,
      description:
          'Rice adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/rice/thumbnail.webp',
      rating: 4.6,
      reviewCount: 436,
      soldCount: 115,
    ),
    Product(
      id: 'p039',
      name: 'Soft Drinks',
      category: 'Bahan Makanan',
      price: 32000,
      description:
          'Soft Drinks adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/soft-drinks/thumbnail.webp',
      rating: 4.3,
      reviewCount: 473,
      soldCount: 144,
    ),
    Product(
      id: 'p040',
      name: 'Strawberry',
      category: 'Bahan Makanan',
      price: 64000,
      description:
          'Strawberry adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/strawberry/thumbnail.webp',
      rating: 4.0,
      reviewCount: 510,
      soldCount: 173,
    ),
    Product(
      id: 'p041',
      name: 'Tissue Paper Box',
      category: 'Bahan Makanan',
      price: 40000,
      description:
          'Tissue Paper Box adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/tissue-paper-box/thumbnail.webp',
      rating: 4.7,
      reviewCount: 547,
      soldCount: 202,
    ),
    Product(
      id: 'p042',
      name: 'Water',
      category: 'Bahan Makanan',
      price: 16000,
      description:
          'Water adalah produk kategori Bahan Makanan untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/groceries/water/thumbnail.webp',
      rating: 4.4,
      reviewCount: 584,
      soldCount: 231,
    ),
    Product(
      id: 'p043',
      name: 'Decoration Swing',
      category: 'Dekorasi Rumah',
      price: 960000,
      description:
          'Decoration Swing adalah produk kategori Dekorasi Rumah untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/home-decoration/decoration-swing/thumbnail.webp',
      rating: 4.1,
      reviewCount: 621,
      soldCount: 260,
    ),
    Product(
      id: 'p044',
      name: 'Family Tree Photo Frame',
      category: 'Dekorasi Rumah',
      price: 480000,
      description:
          'Family Tree Photo Frame adalah produk kategori Dekorasi Rumah untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/home-decoration/family-tree-photo-frame/thumbnail.webp',
      rating: 4.8,
      reviewCount: 658,
      soldCount: 289,
    ),
    Product(
      id: 'p045',
      name: 'House Showpiece Plant',
      category: 'Dekorasi Rumah',
      price: 640000,
      description:
          'House Showpiece Plant adalah produk kategori Dekorasi Rumah untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/home-decoration/house-showpiece-plant/thumbnail.webp',
      rating: 4.5,
      reviewCount: 695,
      soldCount: 318,
    ),
    Product(
      id: 'p046',
      name: 'Plant Pot',
      category: 'Dekorasi Rumah',
      price: 240000,
      description:
          'Plant Pot adalah produk kategori Dekorasi Rumah untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/home-decoration/plant-pot/thumbnail.webp',
      rating: 4.2,
      reviewCount: 732,
      soldCount: 347,
    ),
    Product(
      id: 'p047',
      name: 'Table Lamp',
      category: 'Dekorasi Rumah',
      price: 800000,
      description:
          'Table Lamp adalah produk kategori Dekorasi Rumah untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/home-decoration/table-lamp/thumbnail.webp',
      rating: 4.9,
      reviewCount: 769,
      soldCount: 376,
    ),
    Product(
      id: 'p048',
      name: 'Bamboo Spatula',
      category: 'Peralatan Dapur',
      price: 128000,
      description:
          'Bamboo Spatula adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/bamboo-spatula/thumbnail.webp',
      rating: 4.6,
      reviewCount: 806,
      soldCount: 405,
    ),
    Product(
      id: 'p049',
      name: 'Black Aluminium Cup',
      category: 'Peralatan Dapur',
      price: 96000,
      description:
          'Black Aluminium Cup adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/black-aluminium-cup/thumbnail.webp',
      rating: 4.3,
      reviewCount: 843,
      soldCount: 434,
    ),
    Product(
      id: 'p050',
      name: 'Black Whisk',
      category: 'Peralatan Dapur',
      price: 160000,
      description:
          'Black Whisk adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/black-whisk/thumbnail.webp',
      rating: 4.0,
      reviewCount: 880,
      soldCount: 463,
    ),
    Product(
      id: 'p051',
      name: 'Boxed Blender',
      category: 'Peralatan Dapur',
      price: 640000,
      description:
          'Boxed Blender adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/boxed-blender/thumbnail.webp',
      rating: 4.7,
      reviewCount: 917,
      soldCount: 492,
    ),
    Product(
      id: 'p052',
      name: 'Carbon Steel Wok',
      category: 'Peralatan Dapur',
      price: 480000,
      description:
          'Carbon Steel Wok adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/carbon-steel-wok/thumbnail.webp',
      rating: 4.4,
      reviewCount: 954,
      soldCount: 25,
    ),
    Product(
      id: 'p053',
      name: 'Chopping Board',
      category: 'Peralatan Dapur',
      price: 208000,
      description:
          'Chopping Board adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/chopping-board/thumbnail.webp',
      rating: 4.1,
      reviewCount: 991,
      soldCount: 54,
    ),
    Product(
      id: 'p054',
      name: 'Citrus Squeezer Yellow',
      category: 'Peralatan Dapur',
      price: 144000,
      description:
          'Citrus Squeezer Yellow adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/citrus-squeezer-yellow/thumbnail.webp',
      rating: 4.8,
      reviewCount: 43,
      soldCount: 83,
    ),
    Product(
      id: 'p055',
      name: 'Egg Slicer',
      category: 'Peralatan Dapur',
      price: 112000,
      description:
          'Egg Slicer adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/egg-slicer/thumbnail.webp',
      rating: 4.5,
      reviewCount: 80,
      soldCount: 112,
    ),
    Product(
      id: 'p056',
      name: 'Electric Stove',
      category: 'Peralatan Dapur',
      price: 800000,
      description:
          'Electric Stove adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/electric-stove/thumbnail.webp',
      rating: 4.2,
      reviewCount: 117,
      soldCount: 141,
    ),
    Product(
      id: 'p057',
      name: 'Fine Mesh Strainer',
      category: 'Peralatan Dapur',
      price: 160000,
      description:
          'Fine Mesh Strainer adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/fine-mesh-strainer/thumbnail.webp',
      rating: 4.9,
      reviewCount: 154,
      soldCount: 170,
    ),
    Product(
      id: 'p058',
      name: 'Fork',
      category: 'Peralatan Dapur',
      price: 64000,
      description:
          'Fork adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/fork/thumbnail.webp',
      rating: 4.6,
      reviewCount: 191,
      soldCount: 199,
    ),
    Product(
      id: 'p059',
      name: 'Glass',
      category: 'Peralatan Dapur',
      price: 80000,
      description:
          'Glass adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/glass/thumbnail.webp',
      rating: 4.3,
      reviewCount: 228,
      soldCount: 228,
    ),
    Product(
      id: 'p060',
      name: 'Grater Black',
      category: 'Peralatan Dapur',
      price: 176000,
      description:
          'Grater Black adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/grater-black/thumbnail.webp',
      rating: 4.0,
      reviewCount: 265,
      soldCount: 257,
    ),
    Product(
      id: 'p061',
      name: 'Hand Blender',
      category: 'Peralatan Dapur',
      price: 560000,
      description:
          'Hand Blender adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/hand-blender/thumbnail.webp',
      rating: 4.7,
      reviewCount: 302,
      soldCount: 286,
    ),
    Product(
      id: 'p062',
      name: 'Ice Cube Tray',
      category: 'Peralatan Dapur',
      price: 96000,
      description:
          'Ice Cube Tray adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/ice-cube-tray/thumbnail.webp',
      rating: 4.4,
      reviewCount: 339,
      soldCount: 315,
    ),
    Product(
      id: 'p063',
      name: 'Kitchen Sieve',
      category: 'Peralatan Dapur',
      price: 128000,
      description:
          'Kitchen Sieve adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/kitchen-sieve/thumbnail.webp',
      rating: 4.1,
      reviewCount: 376,
      soldCount: 344,
    ),
    Product(
      id: 'p064',
      name: 'Knife',
      category: 'Peralatan Dapur',
      price: 240000,
      description:
          'Knife adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/knife/thumbnail.webp',
      rating: 4.8,
      reviewCount: 413,
      soldCount: 373,
    ),
    Product(
      id: 'p065',
      name: 'Lunch Box',
      category: 'Peralatan Dapur',
      price: 208000,
      description:
          'Lunch Box adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/lunch-box/thumbnail.webp',
      rating: 4.5,
      reviewCount: 450,
      soldCount: 402,
    ),
    Product(
      id: 'p066',
      name: 'Microwave Oven',
      category: 'Peralatan Dapur',
      price: 1440000,
      description:
          'Microwave Oven adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/microwave-oven/thumbnail.webp',
      rating: 4.2,
      reviewCount: 487,
      soldCount: 431,
    ),
    Product(
      id: 'p067',
      name: 'Mug Tree Stand',
      category: 'Peralatan Dapur',
      price: 256000,
      description:
          'Mug Tree Stand adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/mug-tree-stand/thumbnail.webp',
      rating: 4.9,
      reviewCount: 524,
      soldCount: 460,
    ),
    Product(
      id: 'p068',
      name: 'Pan',
      category: 'Peralatan Dapur',
      price: 400000,
      description:
          'Pan adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/pan/thumbnail.webp',
      rating: 4.6,
      reviewCount: 561,
      soldCount: 489,
    ),
    Product(
      id: 'p069',
      name: 'Plate',
      category: 'Peralatan Dapur',
      price: 64000,
      description:
          'Plate adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/plate/thumbnail.webp',
      rating: 4.3,
      reviewCount: 598,
      soldCount: 22,
    ),
    Product(
      id: 'p070',
      name: 'Red Tongs',
      category: 'Peralatan Dapur',
      price: 112000,
      description:
          'Red Tongs adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/red-tongs/thumbnail.webp',
      rating: 4.0,
      reviewCount: 635,
      soldCount: 51,
    ),
    Product(
      id: 'p071',
      name: 'Silver Pot With Glass Cap',
      category: 'Peralatan Dapur',
      price: 640000,
      description:
          'Silver Pot With Glass Cap adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/silver-pot-with-glass-cap/thumbnail.webp',
      rating: 4.7,
      reviewCount: 672,
      soldCount: 80,
    ),
    Product(
      id: 'p072',
      name: 'Slotted Turner',
      category: 'Peralatan Dapur',
      price: 144000,
      description:
          'Slotted Turner adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/slotted-turner/thumbnail.webp',
      rating: 4.4,
      reviewCount: 709,
      soldCount: 109,
    ),
    Product(
      id: 'p073',
      name: 'Spice Rack',
      category: 'Peralatan Dapur',
      price: 320000,
      description:
          'Spice Rack adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/spice-rack/thumbnail.webp',
      rating: 4.1,
      reviewCount: 746,
      soldCount: 138,
    ),
    Product(
      id: 'p074',
      name: 'Spoon',
      category: 'Peralatan Dapur',
      price: 80000,
      description:
          'Spoon adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/spoon/thumbnail.webp',
      rating: 4.8,
      reviewCount: 783,
      soldCount: 167,
    ),
    Product(
      id: 'p075',
      name: 'Tray',
      category: 'Peralatan Dapur',
      price: 272000,
      description:
          'Tray adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/tray/thumbnail.webp',
      rating: 4.5,
      reviewCount: 820,
      soldCount: 196,
    ),
    Product(
      id: 'p076',
      name: 'Wooden Rolling Pin',
      category: 'Peralatan Dapur',
      price: 192000,
      description:
          'Wooden Rolling Pin adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/wooden-rolling-pin/thumbnail.webp',
      rating: 4.2,
      reviewCount: 857,
      soldCount: 225,
    ),
    Product(
      id: 'p077',
      name: 'Yellow Peeler',
      category: 'Peralatan Dapur',
      price: 96000,
      description:
          'Yellow Peeler adalah produk kategori Peralatan Dapur untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/kitchen-accessories/yellow-peeler/thumbnail.webp',
      rating: 4.9,
      reviewCount: 894,
      soldCount: 254,
    ),
    Product(
      id: 'p078',
      name: 'Apple MacBook Pro 14 Inch Space Grey',
      category: 'Laptop',
      price: 32000000,
      description:
          'Apple MacBook Pro 14 Inch Space Grey adalah produk kategori Laptop untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/laptops/apple-macbook-pro-14-inch-space-grey/thumbnail.webp',
      rating: 4.6,
      reviewCount: 931,
      soldCount: 283,
    ),
    Product(
      id: 'p079',
      name: 'Asus Zenbook Pro Dual Screen Laptop',
      category: 'Laptop',
      price: 28800000,
      description:
          'Asus Zenbook Pro Dual Screen Laptop adalah produk kategori Laptop untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/laptops/asus-zenbook-pro-dual-screen-laptop/thumbnail.webp',
      rating: 4.3,
      reviewCount: 968,
      soldCount: 312,
    ),
    Product(
      id: 'p080',
      name: 'Huawei Matebook X Pro',
      category: 'Laptop',
      price: 22400000,
      description:
          'Huawei Matebook X Pro adalah produk kategori Laptop untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/laptops/huawei-matebook-x-pro/thumbnail.webp',
      rating: 4.0,
      reviewCount: 20,
      soldCount: 341,
    ),
    Product(
      id: 'p081',
      name: 'Lenovo Yoga 920',
      category: 'Laptop',
      price: 17600000,
      description:
          'Lenovo Yoga 920 adalah produk kategori Laptop untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/laptops/lenovo-yoga-920/thumbnail.webp',
      rating: 4.7,
      reviewCount: 57,
      soldCount: 370,
    ),
    Product(
      id: 'p082',
      name: 'New DELL XPS 13 9300 Laptop',
      category: 'Laptop',
      price: 24000000,
      description:
          'New DELL XPS 13 9300 Laptop adalah produk kategori Laptop untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/laptops/new-dell-xps-13-9300-laptop/thumbnail.webp',
      rating: 4.4,
      reviewCount: 94,
      soldCount: 399,
    ),
    Product(
      id: 'p083',
      name: 'Blue & Black Check Shirt',
      category: 'Pakaian Pria',
      price: 480000,
      description:
          'Blue & Black Check Shirt adalah produk kategori Pakaian Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shirts/blue-&-black-check-shirt/thumbnail.webp',
      rating: 4.1,
      reviewCount: 131,
      soldCount: 428,
    ),
    Product(
      id: 'p084',
      name: 'Gigabyte Aorus Men Tshirt',
      category: 'Pakaian Pria',
      price: 400000,
      description:
          'Gigabyte Aorus Men Tshirt adalah produk kategori Pakaian Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shirts/gigabyte-aorus-men-tshirt/thumbnail.webp',
      rating: 4.8,
      reviewCount: 168,
      soldCount: 457,
    ),
    Product(
      id: 'p085',
      name: 'Man Plaid Shirt',
      category: 'Pakaian Pria',
      price: 560000,
      description:
          'Man Plaid Shirt adalah produk kategori Pakaian Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shirts/man-plaid-shirt/thumbnail.webp',
      rating: 4.5,
      reviewCount: 205,
      soldCount: 486,
    ),
    Product(
      id: 'p086',
      name: 'Man Short Sleeve Shirt',
      category: 'Pakaian Pria',
      price: 320000,
      description:
          'Man Short Sleeve Shirt adalah produk kategori Pakaian Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shirts/man-short-sleeve-shirt/thumbnail.webp',
      rating: 4.2,
      reviewCount: 242,
      soldCount: 19,
    ),
    Product(
      id: 'p087',
      name: 'Men Check Shirt',
      category: 'Pakaian Pria',
      price: 448000,
      description:
          'Men Check Shirt adalah produk kategori Pakaian Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shirts/men-check-shirt/thumbnail.webp',
      rating: 4.9,
      reviewCount: 279,
      soldCount: 48,
    ),
    Product(
      id: 'p088',
      name: 'Nike Air Jordan 1 Red And Black',
      category: 'Sepatu Pria',
      price: 2400000,
      description:
          'Nike Air Jordan 1 Red And Black adalah produk kategori Sepatu Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shoes/nike-air-jordan-1-red-and-black/thumbnail.webp',
      rating: 4.6,
      reviewCount: 316,
      soldCount: 77,
    ),
    Product(
      id: 'p089',
      name: 'Nike Baseball Cleats',
      category: 'Sepatu Pria',
      price: 1280000,
      description:
          'Nike Baseball Cleats adalah produk kategori Sepatu Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shoes/nike-baseball-cleats/thumbnail.webp',
      rating: 4.3,
      reviewCount: 353,
      soldCount: 106,
    ),
    Product(
      id: 'p090',
      name: 'Puma Future Rider Trainers',
      category: 'Sepatu Pria',
      price: 1440000,
      description:
          'Puma Future Rider Trainers adalah produk kategori Sepatu Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shoes/puma-future-rider-trainers/thumbnail.webp',
      rating: 4.0,
      reviewCount: 390,
      soldCount: 135,
    ),
    Product(
      id: 'p091',
      name: 'Sports Sneakers Off White & Red',
      category: 'Sepatu Pria',
      price: 1920000,
      description:
          'Sports Sneakers Off White & Red adalah produk kategori Sepatu Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shoes/sports-sneakers-off-white-&-red/thumbnail.webp',
      rating: 4.7,
      reviewCount: 427,
      soldCount: 164,
    ),
    Product(
      id: 'p092',
      name: 'Sports Sneakers Off White Red',
      category: 'Sepatu Pria',
      price: 1760000,
      description:
          'Sports Sneakers Off White Red adalah produk kategori Sepatu Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-shoes/sports-sneakers-off-white-red/thumbnail.webp',
      rating: 4.4,
      reviewCount: 464,
      soldCount: 193,
    ),
    Product(
      id: 'p093',
      name: 'Brown Leather Belt Watch',
      category: 'Jam Tangan Pria',
      price: 1440000,
      description:
          'Brown Leather Belt Watch adalah produk kategori Jam Tangan Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-watches/brown-leather-belt-watch/thumbnail.webp',
      rating: 4.1,
      reviewCount: 501,
      soldCount: 222,
    ),
    Product(
      id: 'p094',
      name: 'Longines Master Collection',
      category: 'Jam Tangan Pria',
      price: 24000000,
      description:
          'Longines Master Collection adalah produk kategori Jam Tangan Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-watches/longines-master-collection/thumbnail.webp',
      rating: 4.8,
      reviewCount: 538,
      soldCount: 251,
    ),
    Product(
      id: 'p095',
      name: 'Rolex Cellini Date Black Dial',
      category: 'Jam Tangan Pria',
      price: 144000000,
      description:
          'Rolex Cellini Date Black Dial adalah produk kategori Jam Tangan Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-watches/rolex-cellini-date-black-dial/thumbnail.webp',
      rating: 4.5,
      reviewCount: 575,
      soldCount: 280,
    ),
    Product(
      id: 'p096',
      name: 'Rolex Cellini Moonphase',
      category: 'Jam Tangan Pria',
      price: 208000000,
      description:
          'Rolex Cellini Moonphase adalah produk kategori Jam Tangan Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-watches/rolex-cellini-moonphase/thumbnail.webp',
      rating: 4.2,
      reviewCount: 612,
      soldCount: 309,
    ),
    Product(
      id: 'p097',
      name: 'Rolex Datejust',
      category: 'Jam Tangan Pria',
      price: 176000000,
      description:
          'Rolex Datejust adalah produk kategori Jam Tangan Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-watches/rolex-datejust/thumbnail.webp',
      rating: 4.9,
      reviewCount: 649,
      soldCount: 338,
    ),
    Product(
      id: 'p098',
      name: 'Rolex Submariner Watch',
      category: 'Jam Tangan Pria',
      price: 224000000,
      description:
          'Rolex Submariner Watch adalah produk kategori Jam Tangan Pria untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mens-watches/rolex-submariner-watch/thumbnail.webp',
      rating: 4.6,
      reviewCount: 686,
      soldCount: 367,
    ),
    Product(
      id: 'p099',
      name: 'Amazon Echo Plus',
      category: 'Aksesori Elektronik',
      price: 1600000,
      description:
          'Amazon Echo Plus adalah produk kategori Aksesori Elektronik untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mobile-accessories/amazon-echo-plus/thumbnail.webp',
      rating: 4.3,
      reviewCount: 723,
      soldCount: 396,
    ),
    Product(
      id: 'p100',
      name: 'Apple Airpods',
      category: 'Aksesori Elektronik',
      price: 2080000,
      description:
          'Apple Airpods adalah produk kategori Aksesori Elektronik untuk kebutuhan sehari-hari dengan desain praktis dan kualitas yang cocok untuk penggunaan rutin.',
      imageUrl:
          'https://cdn.dummyjson.com/product-images/mobile-accessories/apple-airpods/thumbnail.webp',
      rating: 4.0,
      reviewCount: 760,
      soldCount: 425,
    ),
  ];

  static Future<List<Product>> fetchProducts({
    required int page,
    int limit = 20,
    String query = '',
    String category = 'Semua',
    String sortOption = 'Default',
  }) async {
    // simulasi waktu request ke API
    await Future.delayed(const Duration(milliseconds: 800));

    final normalizedQuery = query.trim().toLowerCase();

    var filtered = products.where((product) {
      final searchableText =
          '''
      ${product.name}
      ${product.category}
      ${product.description}
'''
              .toLowerCase();
      final matchesQuery = searchableText.contains(normalizedQuery);

      final matchesCategory =
          category == 'Semua' || product.category == category;

      return matchesQuery && matchesCategory;
    }).toList();

    if (sortOption == 'Harga Terendah') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    }

    if (sortOption == 'Harga Tertinggi') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    }

    // /////////////////////

    final startIndex = (page - 1) * limit;

    if (startIndex >= filtered.length) {
      return [];
    }

    final endIndex = startIndex + limit < filtered.length
        ? startIndex + limit
        : filtered.length;

    return filtered.sublist(startIndex, endIndex);
  }
}
