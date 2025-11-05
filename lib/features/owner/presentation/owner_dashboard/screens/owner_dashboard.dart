import 'package:flutter/material.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/widgets/stat_card.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        spacing: 28,
        children: <Widget>[
          GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            children: <Widget>[
              StatCard(label: 'Factories'),
              StatCard(label: 'Factories'),
              StatCard(label: 'Factories'),
              StatCard(label: 'Factories'),
            ],
          ),
          Container(
            decoration: BoxDecoration(border: BoxBorder.all()),
            child: Text('hello'),
          ),
        ],
      ),
    );
  }
}
