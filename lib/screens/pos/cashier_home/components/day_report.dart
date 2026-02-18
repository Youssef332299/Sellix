import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/localization/app_localization.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TranslationService.tr("reports"))),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("paid_invoices")
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final invoices = snapshot.data!.docs;

          double totalRevenue = 0;
          Map<String, dynamic> productCounts = {};

          for (var doc in invoices) {
            // total as double
            totalRevenue += (doc["total"] ?? 0).toDouble();

            for (var item in doc["items"]) {
              final name = item["name"] ?? "-";
              final qty = (item["qty"] ?? 0).toInt(); // convert num to int
              productCounts[name] = (productCounts[name] ?? 0) + qty;
            }
          }

          final bestProduct = productCounts.entries.isEmpty
              ? "-"
              : productCounts.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key;

          return Column(
            children: [
              ListTile(
                title: Text(
                    "${TranslationService.tr("total_revenue")} : ${totalRevenue.toStringAsFixed(2)}"),
              ),
              ListTile(
                title: Text(
                    "${TranslationService.tr("total_orders")} : ${invoices.length}"),
              ),
              ListTile(
                title: Text(
                    "${TranslationService.tr("best_seller")} : $bestProduct"),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: invoices.length,
                  itemBuilder: (context, index) {
                    final doc = invoices[index];
                    final paid = (doc['paid'] ?? 0).toDouble();
                    final total = (doc['total'] ?? 0).toDouble();
                    return ListTile(
                      title: Text("Invoice ID: ${doc.id}"),
                      subtitle: Text(
                          "${TranslationService.tr("total")} : ${total.toStringAsFixed(2)}, ${TranslationService.tr("paid")} : ${paid.toStringAsFixed(2)}"),
                      trailing: Text(doc['paymentMethod'] ?? "-"),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
