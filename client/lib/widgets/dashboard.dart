import '../../utilities/imports.dart';

Widget menuOption(Color color, Icon icon,Widget page,String message,BuildContext context){
  return Padding(
    padding:
    const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
    child: Material(
      color: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 70,
              color: Theme.of(context).iconTheme.color,
              icon: icon,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: page));
              },
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );
}

Widget menuOption2(Color color, Icon icon,Widget page,String message,BuildContext context){
  return Padding(
    padding:
    const EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
    child: Material(
      color: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 140,
        height:  90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 40,
              color: Colors.white,
              icon: icon,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: page));
              },
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    ),
  );
}



