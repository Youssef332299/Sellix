import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellix/screens/pos/cashier_home/widgets/kitchen/state.dart';
import '../../../../../core/colors/app_colors.dart';
import 'components/history.dart';
import 'components/section_board.dart';
import 'cubit.dart';

class KitchenPage extends StatefulWidget {
  const KitchenPage({super.key});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KitchenCubit(),
      child: Scaffold(
        drawer: const KitchenHistoryPage(),
        backgroundColor: AppColors.primary800,
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<KitchenCubit, KitchenState>(
                builder: (context, state) {
                  final sections =
                  state.orders.map((e) => e.section).toSet().toList();

                  if (sections.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Orders",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return PageView(
                    controller: _controller,
                    children: sections.map((s) {
                      final list = state.orders
                          .where((e) => e.section == s)
                          .toList();

                      return SectionBoard(
                        section: s,
                        orders: list,
                        timers: state.timers,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
