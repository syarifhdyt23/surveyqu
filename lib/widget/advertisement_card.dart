import 'package:flutter/material.dart';

class AdvertisementCard extends StatelessWidget {
  final Function onTap;
  final String gambar, isi;

  const AdvertisementCard({Key key, this.onTap, this.gambar, this.isi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        //     (){
        //   this.openURL(context, listNews[i].url);
        // },
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(gambar),
                fit: BoxFit.cover,
              ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
          ),
          // child: Container(
          //   margin: EdgeInsets.only(top: 10),
          //   child: Text(isi, style: TextStyle(fontWeight: FontWeight.w600),),
          // ),
        )
    );
  }
}
