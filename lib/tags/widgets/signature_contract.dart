import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/sign_here.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignatureContract extends StatefulWidget {
  /*final String uuid;
  final Image signature;*/
  final Function onTap;
  final Function onCompleted;
  /*final Rect rect;
  final double width;
  final double height;*/

  SignatureContract({/*this.uuid, this.signature,*/ this.onTap,this.onCompleted/* this.rect, this.width, this.height*/});

  @override
  _SignatureContractState createState() => _SignatureContractState();
}

class _SignatureContractState extends State<SignatureContract> {
  ResizableWidgetController widgetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTap( WrapperWidget.of(context).uuid, "UserUUID");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("TagBuilder: SignatureContract");
    if (WrapperWidget.of(context).data != null && Functions().cast<TagDataModel>(WrapperWidget.of(context).data).signature!=null)
      widget.onCompleted(WrapperWidget.of(context).uuid, "SignatureContract",WrapperWidget.of(context).data);
    return ResizebleWidget(
      width: WrapperWidget.of(context).width,
      height: WrapperWidget.of(context).height,
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      widgetController: widgetController,
      onWidgetControllerInitialized: (ResizableWidgetController c){
        widgetController = c;
        c.resize(WrapperWidget.of(context).scaledWidth, WrapperWidget.of(context).scaledHeight);
      },
      isDraggable: false,
      child: Container(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
                child: SignHere(
                  onTap: widget.onTap,
                )),
            Flexible(
              flex: 1,
              child: Container(/*
                height: 8,
                width: WrapperWidget.of(context).width,*/
                child: Text(
                    WrapperWidget.of(context).data==null?"UserId to be shown here: UserId":"Userid to be shown here: ${Functions().cast<TagDataModel>(WrapperWidget.of(context).data).userUUID}",
                  style: TextStyle(fontSize: 4),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}