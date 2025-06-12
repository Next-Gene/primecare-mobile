import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../buy_pages/buy_now.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RightTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 10.0;
    final centerY = size.height / 2;

    final top = centerY - 30;
    final bottom = centerY + 30;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, top)
      ..arcToPoint(
        Offset(size.width, bottom),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        final items = cubit.items;

        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight,
              ),
              Container(
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/back_buy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];

                              return Dismissible(
                                key: Key(item.name),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  height: 100,
                                  alignment: Alignment.centerRight,
                                  color: Colors.red.shade500,
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  cubit.removeItem(item);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${item.name} has been deleted')),
                                  );
                                },
                                child: ClipPath(
                                  clipper: RightTicketClipper(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade300,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: 110,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 10, right: 25, top: 10),
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          item.image,
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.remove, color: Colors.white),
                                                  iconSize: 20,
                                                  onPressed: () {
                                                    cubit.decreaseCount(item);
                                                  },
                                                ),
                                                Container(
                                                  width: 25,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${item.count}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.add, color: Colors.white),
                                                  iconSize: 20,
                                                  onPressed: () {
                                                    cubit.increaseCount(item);
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '\$${item.price * item.count}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${cubit.totalPrice}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5785FF),
                                Color(0xFF002A99),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: MaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Proceeding to payment...")),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => BuyNow()),
                              );
                            },
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
