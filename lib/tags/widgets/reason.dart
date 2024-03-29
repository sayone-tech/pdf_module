import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class Reason extends StatefulWidget {
  Function onCompleted;
  Function onTap;
  final String value;
  final bool isCfrChild;

  Reason({this.onCompleted, this.onTap, this.value, this.isCfrChild = false});

  @override
  _ReasonState createState() => _ReasonState();
}

class _ReasonState extends State<Reason> {
  var _pickerData = "Select a reason";
  ResizableWidgetController widgetController;

  List<String> _arrayData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (WrapperWidget.of(context).data== null || WrapperWidget.of(context).data.reasonList == null) {
        widget.onTap(WrapperWidget
          .of(context)
          .uuid, "Reason");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (WrapperWidget.of(context).data!=null && WrapperWidget
        .of(context)
        .data.reasonList != null) {
      _arrayData = WrapperWidget
          .of(context)
          .data.reasonList;
    }
    if(WrapperWidget.of(context).data!=null && WrapperWidget.of(context).data.reasonSelected!=null)
      _pickerData = WrapperWidget.of(context).data.reasonSelected;

    return widget.isCfrChild?Container(
      color: const Color.fromRGBO(216, 243, 254, 1.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(isExpanded: true,
            value: _pickerData,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 14,
            elevation: 14,
            dropdownColor: Colors.white,
            style: const TextStyle(color: Colors.black,fontSize: 12),
            onChanged: (String newValue) {
              if(WrapperWidget.of(context).data==null) {
                WrapperWidget.of(context).data = TagDataModel();
              }
              setState(() {
                _pickerData = newValue;
                WrapperWidget.of(context).data.reasonSelected = newValue;
                widget.onCompleted(WrapperWidget
                    .of(context)
                    .uuid, "Reason", WrapperWidget.of(context).data);
              });
            },
            items: _arrayData.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: AutoSizeText(value,style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
        ),
      ),
      // ),

    ):ResizebleWidget(
      width: WrapperWidget.of(context).width,
      height: WrapperWidget.of(context).height,
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      widgetController: widgetController,
      onWidgetControllerInitialized: (ResizableWidgetController c){
        widgetController = c;
        c.resize(WrapperWidget.of(context).scaledWidth, WrapperWidget.of(context).scaledHeight);
      },
      child: Container(
        width: WrapperWidget.of(context).width,
        height: WrapperWidget.of(context).height,
        color: const Color.fromRGBO(216, 243, 254, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(isExpanded: true,
                value: _pickerData,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 18,
                elevation: 14,
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black,fontSize: 13),
                onChanged: (String newValue) {
                if(WrapperWidget.of(context).data==null) {
                  WrapperWidget.of(context).data = TagDataModel();
                }
                  setState(() {
                    _pickerData = newValue;
                    WrapperWidget.of(context).data.reasonSelected = newValue;
                    widget.onCompleted(WrapperWidget
                        .of(context)
                        .uuid, "Reason", WrapperWidget.of(context).data);
                  });
                },
                items: _arrayData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: AutoSizeText(value,style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
              ),
            ),
        ),
        // ),

      ),
    );
  }
}
