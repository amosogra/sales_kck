
import 'package:flutter/material.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/strings.dart';
import 'package:sales_kck/model/post/SyncModel.dart';

class Sync extends StatefulWidget {
  const Sync({Key? key}) : super(key: key);

  @override
  _SyncState createState() => _SyncState();
}

class _SyncState extends State<Sync> {

  List<SyncModel> models = <SyncModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SyncModel model1 = SyncModel(title: 'Customer', total: 166, date: "2021-08-11");
    SyncModel model2 = SyncModel(title: 'Product', total: 0, date: "2021-08-12");
    SyncModel model3 = SyncModel(title: 'Terms', total: 67, date: "2021-08-13");
    SyncModel model4 = SyncModel(title: 'Price History', total: 6, date: "2021-08-14");
    SyncModel model5 = SyncModel(title: 'Tax Type', total: 6, date: "2021-08-15");
    SyncModel model6 = SyncModel(title: 'Invoice', total: 33, date: "2021-08-16");

    models.add(model1);
    models.add(model2);
    models.add(model3);
    models.add(model4);
    models.add(model5);
    models.add(model6);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sync),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25,right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Full Sync"),
                  ),

                  Switch(
                      value: true,
                      onChanged: (value){
                      }
                  )
                ],
              ),
            ),

            Container(
                margin: EdgeInsets.only(top:0),
                child:ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: models.length,
                  itemBuilder: (context, index){
                    return _buildItem(index);
                  },
                )
            )

          ],
        )
      ),
    );
  }

  Widget _buildItem(int index){

    return InkResponse(

      onTap: (){

      },

      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.models[index].title),
                    Text("Total Customer: " + this.models[index].total.toString()),
                    Text("Last Synced: " + this.models[index].date),
                  ],
                ),
              ),
              Icon(Icons.sync)
            ],
          ),
        )
      ),
    );

  }
}


