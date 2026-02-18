import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/localization/app_localization.dart';

class InvoiceService {

  Future<void> printInvoice({
    required List cart,
    required double subtotal,
    required double tax,
    required double total,
    required String orderType,
    String? tableNumber,
  }) async {

    final pdf = pw.Document();

    /// تحميل خط Cairo
    final fontData = await rootBundle.load(fontCairoAsset);
    final ttf = pw.Font.ttf(fontData);

    /// تاريخ ووقت
    final now = DateTime.now();
    final date = DateFormat('yyyy/MM/dd').format(now);
    final time = DateFormat('hh:mm a').format(now);

    /// رقم أوردر عشوائي
    final orderNumber = now.millisecondsSinceEpoch.toString().substring(7);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [

                /// اسم الشركة
                pw.Center(
                  child: pw.Text(
                    companyName,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 6),

                /// الفروع
                ...companyBranches.map((b) => pw.Center(
                  child: pw.Text(
                    b,
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                )),

                pw.SizedBox(height: 6),

                /// التليفونات
                ...companyPhones.map((p) => pw.Center(
                  child: pw.Text(
                    "${TranslationService.tr('tel')}: $p",
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                )),

                pw.Divider(),

                /// بيانات الطلب
                _row(TranslationService.tr('order_number'), orderNumber, ttf),
                _row(TranslationService.tr('date'), date, ttf),
                _row(TranslationService.tr('time'), time, ttf),
                _row(TranslationService.tr('order_type'), orderType, ttf),

                if (orderType == "Dine In" && tableNumber != null)
                  _row(TranslationService.tr('table_number'), tableNumber, ttf),

                pw.Divider(),

                /// عنوان المنتجات
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _text(TranslationService.tr('total'), ttf, bold: true),
                    _text(TranslationService.tr('quantity'), ttf, bold: true),
                    _text(TranslationService.tr('price'), ttf, bold: true),
                    _text(TranslationService.tr('item'), ttf, bold: true),
                  ],
                ),

                pw.Divider(),

                /// المنتجات
                ...cart.map((e) {
                  final lineTotal = e['price'] * e['qty'];
                  return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _text(lineTotal.toStringAsFixed(2), ttf),
                      _text(e['qty'].toString(), ttf),
                      _text(e['price'].toString(), ttf),
                      _text(e['name'], ttf),
                    ],
                  );
                }),

                pw.Divider(),

                /// الحسابات
                _row(
                  TranslationService.tr('subtotal_before_tax'),
                  subtotal.toStringAsFixed(2),
                  ttf,
                ),
                _row(
                  TranslationService.tr('tax'),
                  tax.toStringAsFixed(2),
                  ttf,
                ),

                pw.SizedBox(height: 6),

                pw.Center(
                  child: pw.Text(
                    "${TranslationService.tr('total')} ${total.toStringAsFixed(2)} EGP",
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 10),

                /// معلومات الطلب
                pw.Center(
                  child: pw.Text(
                    ordersInfo,
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                ),

                pw.SizedBox(height: 8),

                pw.Center(
                  child: pw.Text(
                    TranslationService.tr('thank_you'),
                    style: pw.TextStyle(font: ttf, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  static pw.Widget _row(String title, String value, pw.Font font) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(value, style: pw.TextStyle(font: font)),
        pw.Text(title, style: pw.TextStyle(font: font)),
      ],
    );
  }

  static pw.Widget _text(String text, pw.Font font, {bool bold = false}) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        font: font,
        fontSize: 10,
        fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }
}
