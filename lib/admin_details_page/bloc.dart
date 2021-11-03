import 'package:abs_fitness/Resources/Constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'event.dart';
import 'state.dart';

class AdminDetailsPageBloc
    extends Bloc<AdminDetailsPageEvent, AdminDetailsPageState> {
  AdminDetailsPageBloc() : super(AdminDetailsPageState().init());
  Firestore fs = Firestore.instance;
  List<Widget> listItems = [];
  List<String> docIDListItems = [];

  @override
  Stream<AdminDetailsPageState> mapEventToState(
      AdminDetailsPageEvent event) async* {
    if (event is InitEvent) {
      listItems.clear();
      yield await init();
    } else if (event is LoadUIEvent) {
      await getData(event.context, event.planName);
      yield UILoaded(listItems);
    } else if (event is CloseRequestEvent) {
      if (listItems.isNotEmpty) {
        await removeRequest(event.index, event.planName);
        yield LoadingUI();
        yield UILoaded(listItems);
      }
    } else if (event is LeavePageEvent) {
      print("Setting state to Leave");
      listItems.clear();
      yield LeaveState();
    }
  }

  Future<void> removeRequest(int index, String planName) async {
    String docID = docIDListItems[index];
    await fs
        .collection("Inquiry")
        .document("List")
        .collection(planName)
        .document(docID)
        .delete();
    docIDListItems.removeAt(index);
    listItems.removeAt(index);
  }

  Future<AdminDetailsPageState> init() async {
    return state.clone();
  }

  Future<void> getData(BuildContext context, String planName) async {
    listItems.clear();
    QuerySnapshot q = await fs
        .collection("Inquiry")
        .document("List")
        .collection(planName)
        .getDocuments();
    List<DocumentSnapshot> docs = q.documents;
    String name;
    String phnNumber;
    String emailID;
    String image;
    docs.forEach(
      (post) async {
        name = await post.data['Name'];
        phnNumber = await post.data['Phone Number'];
        emailID = await post.data['Email'];
        image = await post.data['Image'];
        ImageProvider img;
        if (image == profileImageAsset) {
          img = Image.asset(image).image;
        } else {
          img = await Image.network(image).image;
        }

        docIDListItems.add(post.documentID);
        listItems.add(
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: FlipCard(
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              front: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(image: img, fit: BoxFit.fill),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment(-1.0, 1.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                ),
              ),
              back: Container(
                height: 150,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Icon(Icons.phone)),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(flex: 2, child: Text(phnNumber)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Icon(Icons.email)),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(flex: 2, child: Text(emailID)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
