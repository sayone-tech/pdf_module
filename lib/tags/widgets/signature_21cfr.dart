import 'package:flutter/material.dart';
import 'package:pdf_module/common/functions.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/reason.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/sign_here.dart';
import 'package:pdf_module/tags/widgets/signer_name.dart';
import 'package:pdf_module/tags/widgets/time_stamp.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class Signature21CFR extends StatefulWidget {
  final Function onTap;
  final Function onCompleted;

  const Signature21CFR(
      {this.onTap,
      this.onCompleted
      });

  @override
  _Signature21CFRState createState() => _Signature21CFRState();
}

class _Signature21CFRState extends State<Signature21CFR> {
  ResizableWidgetController widgetController;
  bool isReasonSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (WrapperWidget.of(context).data== null || WrapperWidget.of(context).data.userUUID == null) {
        widget.onTap(WrapperWidget.of(context).uuid, "UserUUID");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data != null &&
        Functions()
                .cast<TagDataModel>(WrapperWidget.of(context).data)
                .signature !=
            null &&
        isReasonSelected) {
      widget.onCompleted(WrapperWidget.of(context).uuid, "Signature21CFR",
          WrapperWidget.of(context).data);
    }
    return ResizebleWidget(
      width: WrapperWidget.of(context).width,
      height: WrapperWidget.of(context).height,
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      widgetController: widgetController,
      onWidgetControllerInitialized: (ResizableWidgetController c) {
        widgetController = c;
        c.resize(WrapperWidget.of(context).scaledWidth,
            WrapperWidget.of(context).scaledHeight);
      },
      child: Container(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: SignHere(
                      width: WrapperWidget.of(context).width/2,
                      height: WrapperWidget.of(context).height*(4*7),
                      onTap: (uuid, type) {
                        widget.onTap(uuid, type);
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: SignerName(
                              width: WrapperWidget.of(context).width/2,
                              height: WrapperWidget.of(context).height*(4*7),
                              isCfrChild: true,
                              onTap: (uuid, type) {
                                widget.onTap(uuid, type);
                              },
                              onCompleted: (uuid, type, T) {},
                            )),
                        Flexible(
                            fit: FlexFit.tight,
                            child: TimeStamp(
                              width: WrapperWidget.of(context).width/2,
                              height: WrapperWidget.of(context).height*(4*7),
                              isCfrChild: true,
                              onCompleted: (uuid, type, T) {},
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Reason(
                  isCfrChild: true,
                  onCompleted: (uuid, type, T) {
                    isReasonSelected = true;
                    if (Functions()
                            .cast<TagDataModel>(WrapperWidget.of(context).data)
                            .signature !=
                        null) {
                      widget.onCompleted(WrapperWidget.of(context).uuid,
                          "Signature21CFR", WrapperWidget.of(context).data);
                    }
                  },
                  onTap: (uuid, type) {
                    widget.onTap(uuid, type);
                  },
                )),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: WrapperWidget.of(context).height/7,
                width: WrapperWidget.of(context).width,
                child: Text(
                  WrapperWidget.of(context).data == null
                      ? "UserId to be shown here: UserId"
                      : "Userid to be shown here: ${Functions().cast<TagDataModel>(WrapperWidget.of(context).data).userUUID}",
                  style: const TextStyle(color: Colors.black,fontSize: 4),
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
