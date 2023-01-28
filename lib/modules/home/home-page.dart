import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract-page.dart';
import 'package:payflow/modules/home/home-controller.dart';
import 'package:payflow/modules/meus-boletos/meus-boletos-page.dart';
import 'package:payflow/shared/models/boleto-model.dart';
import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';
import 'package:payflow/shared/widgets/boleto-list/boleto-list-widget.dart';
import 'package:payflow/shared/widgets/boleto-tile/boleto-tille-widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageController = new HomePageController();
  final pagesContainer = [
    // Container(child: BoletoListWidget()),
    MeusBoletosPage(),
    ExtractPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
            height: 152,
            color: AppColors.primary,
            child: Center(
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                    text: "Olá, ",
                    style: AppTextStyles.titleRegular,
                    children: [
                      TextSpan(text: "Luxca", style: AppTextStyles.titleBoldBackground),
                    ],
                  ),
                ),
                subtitle: Text(
                  "Mantenha suas contas em dia",
                  style: AppTextStyles.captionShape,
                ),
                trailing: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            )),
      ),
      body: pagesContainer[homePageController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () {
                print("page 0");
                homePageController.setCurrentPage(0);
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                color: AppColors.primary,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("gesture tap");
                // Navigator.pushNamed(context, "/barcode-scanner");
                Navigator.pushNamed(context, "/insert-boleto");
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                print("page 1");
                homePageController.setCurrentPage(1);
                setState(() {});
              },
              icon: Icon(Icons.description_outlined, color: AppColors.body),
            )
          ],
        ),
      ),
    );
  }
}
