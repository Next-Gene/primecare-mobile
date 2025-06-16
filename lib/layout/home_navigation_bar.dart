import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/layout/cubit/cubit.dart';
import 'package:nexgen/layout/cubit/states.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
// استيراداته كما هي

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  bool showChat = false;
  final TextEditingController _messageController = TextEditingController();
  final List<String> messages = [];

  void sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      // استدعاء الدالة الصحيحة في الكيوبت
      AppCubit.get(context).askQuestion(message);

      setState(() {
        messages.add("You: $message");
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getCategory(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AskQuestionSuccessState) {
            setState(() {
              messages.add("Bot: ${state.botReply}");
            });
          }
          if (state is AskQuestionErrorState) {
            setState(() {
              messages.add("Bot: حدث خطأ في استدعاء البوت");
            });
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            floatingActionButton: showChat
                ? null
                : FloatingActionButton(
              onPressed: () {
                setState(() {
                  showChat = true;
                });
              },
              child: const Icon(Icons.chat),
            ),
            body: Stack(
              children: [
                cubit.screens[cubit.selectedIndex],
                if (showChat)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 380,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.smart_toy_rounded, color: Colors.blue),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "NexGen Bot",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      showChat = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.all(10),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final msg = messages[messages.length - 1 - index];
                                final isUser = msg.startsWith("You:");
                                return Align(
                                  alignment:
                                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isUser ? Colors.blueAccent : Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(12),
                                        topRight: const Radius.circular(12),
                                        bottomLeft: Radius.circular(isUser ? 12 : 0),
                                        bottomRight: Radius.circular(isUser ? 0 : 12),
                                      ),
                                    ),
                                    child: Text(
                                      msg.replaceFirst("You: ", "").replaceFirst("Bot: ", ""),
                                      style: TextStyle(
                                        color: isUser ? Colors.white : Colors.black87,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey.shade400),
                                    ),
                                    child: TextField(
                                      controller: _messageController,
                                      decoration: const InputDecoration(
                                        hintText: "Type a message...",
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (_) => sendMessage(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: IconButton(
                                    icon: const Icon(Icons.send, color: Colors.white),
                                    onPressed: sendMessage,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: WaterDropNavBar(
                iconSize: 30,
                backgroundColor: Colors.white,
                waterDropColor: Colors.black,
                barItems: [
                  BarItem(filledIcon: Icons.home_rounded, outlinedIcon: Icons.home_outlined),
                  BarItem(
                      filledIcon: Icons.shopping_cart_rounded,
                      outlinedIcon: Icons.shopping_cart_outlined),
                  BarItem(filledIcon: Icons.person_rounded, outlinedIcon: Icons.person_outline),
                  BarItem(filledIcon: Icons.category_rounded, outlinedIcon: Icons.category_outlined),
                ],
                selectedIndex: cubit.selectedIndex,
                onItemSelected: (index) {
                  cubit.change_bottomnav_bar(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
