import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PromptScreen extends StatefulWidget {
  PromptScreen({Key? key, required this.act, required this.prompt}) : super(key: key);

  String act;
  String prompt;

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  @override
  Widget build(BuildContext context) {
    String command;
    String action;
    try{
      command = widget.prompt.split('"')[0];
      action = widget.prompt.split('"')[1];
    }catch(e){
      command = widget.prompt;
      action = "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.act),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              margin: EdgeInsets.all(16),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: command,
                            ),
                            if(action.isNotEmpty)
                              TextSpan(text: '"${action}"', style: TextStyle(
                              fontWeight: FontWeight.bold
                            ))
                          ]
                        ),
                        style:TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: widget.prompt));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied")));
                            },
                            icon: Icon(Icons.copy, size: 30,)
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
