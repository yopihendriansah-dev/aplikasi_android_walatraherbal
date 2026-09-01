import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final bannerImages = const [
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200',
    'https://images.unsplash.com/photo-1607082348824-0a96f2a18b4?w=1200',
    'https://images.unsplash.com/photo-1556740749-887f6717d7e4?w=1200',
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: .fromLTRB(16, 12, 16, 8),
          child: AspectRatio(
            aspectRatio: 2.1,
            child: ClipRRect(
              borderRadius: .circular(20),
              child: PageView.builder(
                controller: pageController,
                itemCount: bannerImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    bannerImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Colors.grey,
                        child: Center(
                          child: Icon(Icons.broken_image_outlined, size: 48),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),

        // SizedBox(
        //   height: 170,
        //   child: AspectRatio(
        //     aspectRatio: 2.1,
        //     child: PageView.builder(
        //       controller: pageController,
        //       itemCount: bannerImages.length,
        //       onPageChanged: (index) {
        //         setState(() {
        //           currentIndex = index;
        //         });
        //       },

        //       itemBuilder: (context, index) {
        //         return Container(
        //           margin: const .fromLTRB(16, 12, 16, 8),
        //           clipBehavior: .antiAlias,
        //           decoration: BoxDecoration(borderRadius: .circular(20)),
        //           child: Image.network(
        //             bannerImages[index],
        //             fit: .cover,
        //             width: double.infinity,
        //             height: double.infinity,
        //             loadingBuilder: (context, child, loadingProgress) {
        //               if (loadingProgress == null) {
        //                 return child;
        //               }
        //               return const Center(child: CircularProgressIndicator());
        //             },
        //             errorBuilder: (context, error, stackTrace) {
        //               return const ColoredBox(
        //                 color: Colors.grey,
        //                 child: Center(
        //                   child: Icon(Icons.broken_image_outlined, size: 48),
        //                 ),
        //               );
        //             },
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        Row(
          mainAxisAlignment: .center,
          children: List.generate(bannerImages.length, (index) {
            final isActive = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const .symmetric(horizontal: 4),
              width: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade300,
                borderRadius: .circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
