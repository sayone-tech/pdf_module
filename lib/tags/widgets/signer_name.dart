import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/fill_tag_base_design.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class SignerName extends StatefulWidget {
  /*final String uuid;*/
  final bool isCfrChild;
  final Function onTap;
  final Function onCompleted; // return with a string
  /*final Rect rect;*/
  final double width;
  final double height;

  SignerName(
      {
      /*this.uuid,*/ this.onTap,
      this.onCompleted,
      this.isCfrChild = false,
      this.width,
      this.height
      /*this.rect, this.width, this.height*/
      });

  @override
  _SignerNameState createState() => _SignerNameState();
}

class _SignerNameState extends State<SignerName> {
  TextEditingController controller = TextEditingController();
  ResizableWidgetController widgetController;
  bool readOnly = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (WrapperWidget.of(context).data== null || WrapperWidget.of(context).data.signerName == null)
        widget.onTap(WrapperWidget.of(context).uuid, "SignerName");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("TagBuilder: SignerName");
    if (WrapperWidget.of(context).data != null &&
        WrapperWidget.of(context).data.signerName != null)
      widget.onCompleted(WrapperWidget.of(context).uuid, "SignerName",
          WrapperWidget.of(context).data);
    return widget.isCfrChild
        ? FillTagBaseStructure(
            width: widget.width != null
                ? widget.width
                : WrapperWidget.of(context).width,
            height: widget.height != null
                ? widget.height
                : WrapperWidget.of(context).height,
            autoFill: true,
            isCfr: true,
            onCompleted: () {},
            label: WrapperWidget.of(context).data == null ||
                    WrapperWidget.of(context).data.signerName == null
                ? "Signer Name"
                : WrapperWidget.of(context).data.signerName,
          )
        : ResizebleWidget(
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
            isDraggable: false,
            child: FillTagBaseStructure(
              width: WrapperWidget.of(context).width,
              height: WrapperWidget.of(context).height,
              autoFill: true,
              onCompleted: () {},
              label: WrapperWidget.of(context).data == null ||
                      WrapperWidget.of(context).data.signerName == null
                  ? "Signer Name"
                  : WrapperWidget.of(context).data.signerName,
            ),
          );
  }
}
