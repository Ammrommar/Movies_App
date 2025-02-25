import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/CreditsResponse.dart';
import 'package:movies_app/api/api_manager.dart';

import '../responses/ReleasesMoviesResponse.dart';

class SearchItem extends StatefulWidget {
  Results? movie;
  String? url;
  String? backDrop;

  SearchItem({required this.movie, required this.url, required this.backDrop});

  @override
  State<SearchItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<SearchItem> {
  List<Cast> actors = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CreditsResponse?>(
        future: ApiManager.getCredits(
            endPoint: '/3/movie/${widget.movie?.id}/credits'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text('network error'),
                ElevatedButton(
                    onPressed: () {
                      ApiManager.getCredits(
                          endPoint: '/3/movie/${widget.movie?.id}/credits');
                      setState(() {});
                    },
                    child: Text('try again'))
              ],
            );
          }
          if (snapshot.data?.success == false) {
            Column(
              children: [
                Text(snapshot.data!.status_message!),
                ElevatedButton(
                    onPressed: () {
                      ApiManager.getCredits(
                          endPoint: '/3/movie/${widget.movie?.id}/credits');
                      setState(() {});
                    },
                    child: Text('try again'))
              ],
            );
          }
          var actors = snapshot.data!.cast ?? [];

          /* for(int i=0;i<actors.length;i++){
            actorsNames.add(actors[i].name??'');
          }*/

          print(actors.length);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),

                  child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w92${widget.url}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.network(widget
                                  .backDrop ==
                              null
                          ? 'https://img.freepik.com/free-vector/red-exclamation-mark-symbol-attention-caution-sign-icon-alert-danger-problem_40876-3505.jpg?t=st=1710550398~exp=1710553998~hmac=efb1d09681f399b8a31c095c4f3d698c12a3ee3cb060c122803b2b35780415ec&w=92'
                          : "https://image.tmdb.org/t/p/w92${widget.backDrop}")),

                  /// Image.network(widget.url==null?"https://image.tmdb.org/t/p/w92${widget.backDrop}":"https://image.tmdb.org/t/p/w92${widget.url}", )
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    Text(
                      widget.movie?.title ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.movie?.releaseDate ?? '',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        /* Text('$act1 , ',style: TextStyle(color:Colors.grey),),


          Text('$act2 , ',style: TextStyle(color:Colors.grey),),


         Text('$act3 , ',style: TextStyle(color:Colors.grey),),*/

                        /*Text(actors.isEmpty?'':actors[1].name??'', style: TextStyle(color:Colors.grey)),
          Text(','),
          Text(actors.isEmpty?'':actors[2].name??'', style: TextStyle(color:Colors.grey)),*/
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

/*void getcast()async{
  var response= await ApiManager.getCredits(endPoint: '/3/movie/${widget.movie?.id}/credits');
 List<Cast>cast= response?.cast??[];
 actors=cast;
setState(() {

});
}
}*/
