import 'package:flutter/material.dart';

class CustomAddressCityWidget extends StatelessWidget {
  final String? title;
  final String? selected;
  final Function()? onTap;
  final Color? textColor;
  final Color? containerColor;

  const CustomAddressCityWidget(
      {Key? key,
      this.title,
      this.selected,
      this.onTap,
      this.textColor,
      this.containerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title!,
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selected!,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: textColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShowModalBottomSheett extends StatelessWidget {
  final String? hintText;
  final Function()? onChange;
  final int? itemCount;
  final List? listTileTitle;
  final TextEditingController? textFormFieldController;

  const CustomShowModalBottomSheett(
      {Key? key,
      this.hintText,
      this.onChange,
      this.itemCount,
      this.listTileTitle,
      this.textFormFieldController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //TextFormField
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 50,
              child: TextFormField(
                controller: textFormFieldController,
                //initialValue:  controller.first.addressLine ,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 29,
                    ),
                    hintText: hintText,
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    alignLabelWithHint: true),
                onChanged: (v) => onChange!,
              ),
            ),
          ),
          //ListView
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(listTileTitle![index]));
                }),
          )
        ],
      ),
    );
  }
}
