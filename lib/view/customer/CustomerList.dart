import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/services/CustomerService.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/widget/InputForm.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {

  List<CustomerModel> originalItems = <CustomerModel>[];
  List<CustomerModel> customers = <CustomerModel>[];
  final myController = TextEditingController();
  String searchKey = '';

  void loadCustomers() async{
    List<CustomerModel> response = await getCustomers(context);
    if(response.length > 0){
      setState(() {
        response.sort((a, b) => a.name.compareTo(b.name));
        customers = response;
        originalItems = response;
      });
    }else{
      showToastMessage(context, "Token Expired, Logout and Login", "Ok");
    }
  }

  void _printLatestValue() {
    searchItem('${myController.text}');
  }

  void searchItem(String key) {
    List<CustomerModel> tmp = <CustomerModel>[];
    originalItems.forEach((element) {
      if(element.companyCode.toLowerCase().contains(key.toLowerCase()) || element.name.toLowerCase().contains(key.toLowerCase())  || element.accNo.toLowerCase().contains(key.toLowerCase()) ){
        tmp.add(element);
      }
    });
    setState(() {
      customers = tmp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myController.addListener(_printLatestValue);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        loadCustomers();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.customer),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            InputForm(
                              controller: myController,
                              myHint: "Search Customer", validateFunction: (value){
                              return Validations.validateEmpty(value!);
                            },
                              onChange: (value){},
                            ),
                            Divider(color: MyColors.greyColor,)
                          ],
                        )
                    ),
                    searchKey == '' ? Icon(Icons.search, color: MyColors.textGreyColor,) : Icon(Icons.close)
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: customers.length,
                  itemBuilder: (context, index){
                    return _buildItem(customers[index], index);
                  },
                ),
              ),
            ],
          )
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget _buildItem(CustomerModel item, int index) {
    return InkResponse(
      onTap: () async{
        Navigator.pop(context, item.toMap());
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
        //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.name + "  -  " + item.accNo,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),

            Divider(color: MyColors.greyColor,)

          ],
        ),
      ),
    );

  }

}
