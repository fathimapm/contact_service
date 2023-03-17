import 'package:contact_service/src/helpers/common_actions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactPage extends StatefulWidget {
  @override
  createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  bool isLoading= true;
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Visibility(
        visible: !isLoading,
        replacement: Center(child: Lottie.asset("assets/lottie/loader.json")),
        child: Visibility(
          visible: contacts.length>0,
          replacement: Center(child: Text("No Contacts Found")),
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contactItem = contacts[index];
              String mobNos =
                  (contactItem.phones ?? []).map((e) => e.value).join(",");
              return ListTile(
                title: Text("${contactItem.displayName}"),
                subtitle: Text(mobNos),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          String mobNo = contactItem.phones?.first.value ?? "";
                          CommonActions.sendSms(mobNo, "Happy Birthday");
                        },
                        icon: Icon(Icons.sms_outlined)),
                    IconButton(
                        onPressed: () {
                          if(contactItem.phones== null){
                            return;
                          }
                          if (contactItem.phones!.length>1){
showContactNumberDialog(context ,contactItem.phones!);
                          }else {
                            String mobNo = contactItem.phones!.first.value ?? "";

                            CommonActions.makeCall(mobNo);
                          }
                        },
                        icon: Icon(Icons.call)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void getContacts() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status == PermissionStatus.granted) {
      List<Contact> contactsTemp = await ContactsService.getContacts();
      setState(() {
        contacts = contactsTemp;
        isLoading=false;
      });
    }
  }

  void showContactNumberDialog(BuildContext context, List <Item> phone){
showDialog(
context: context,
builder: (context){
  return  AlertDialog(
    title: Text("Choose contact number"),
    content: Container(

      width: 550,
      child: ListView.builder(
        itemCount: phone.length,

        itemBuilder: (context,index){
         Item item= phone[index] ;
         return ListTile(
title: Text(item.value??""),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
IconButton(onPressed:(){
        String mobNo= item.value??"";
        CommonActions.sendSms(mobNo,"");
         },icon: Icon(Icons.sms)),
               IconButton(onPressed:(){
                 String mobNo= item.value??"";
                 CommonActions.makeCall(mobNo);
               },icon: Icon(Icons.call)),
             ],
           ),
         );
        },

        ),

    ),

  );
  }
);
  }
}
