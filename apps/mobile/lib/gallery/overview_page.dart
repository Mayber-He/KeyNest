import 'package:flutter/material.dart';

import '../shared/widgets/app_bottom_navigation.dart';
import 'device_frame.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyNest 界面概览'),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: DeviceFrame(
                child: Column(
                  children: [
                    Expanded(child: _ProductPage(index: _selectedIndex)),
                    AppBottomNavigation(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() => _selectedIndex = index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProductPage extends StatelessWidget {
  const _ProductPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const _HomeProductPage();
    }

    const titles = ['密码库', '生成器', '设置'];
    return Center(child: Text(titles[index - 1]));
  }
}

class _HomeProductPage extends StatelessWidget {
  const _HomeProductPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('下午好', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          '欢迎回到 KeyNest',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
