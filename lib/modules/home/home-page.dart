import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract-page.dart';
import 'package:payflow/modules/home/home-controller.dart';
import 'package:payflow/modules/meus-boletos/meus-boletos-page.dart';
import 'package:payflow/shared/models/user-model.dart';

import 'package:payflow/shared/themes/app-colors.dart';
import 'package:payflow/shared/themes/app-textstyle.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageController = new HomePageController();
  // final pagesContainer = [
  //   // Container(child: BoletoListWidget()),
  //   MeusBoletosPage(key: UniqueKey()),
  //   ExtractPage(key: UniqueKey()),
  // ];

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
                      TextSpan(text: "${widget.user.name}", style: AppTextStyles.titleBoldBackground),
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
                    image: DecorationImage(
                      image: NetworkImage(widget.user.photoUrl!),
                    ),
                  ),
                ),
              ),
            )),
      ),
      body: [
        MeusBoletosPage(key: UniqueKey()),
        ExtractPage(key: UniqueKey()),
      ][homePageController.currentPage],
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
                color: homePageController.currentPage == 0 ? AppColors.primary : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () async {
                print("gesture tap");
                await Navigator.pushNamed(context, "/barcode-scanner");
                setState(() {});
                // Navigator.pushNamed(context, "/insert-boleto");
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
              icon: Icon(
                Icons.description_outlined,
                color: homePageController.currentPage == 1 ? AppColors.primary : AppColors.body,
              ),
            )
          ],
        ),
      ),
    );
  }
}
