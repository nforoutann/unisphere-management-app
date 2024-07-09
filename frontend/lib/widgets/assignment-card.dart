import 'package:flutter/material.dart';
import 'package:frontend/objects/Assignment.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment? assignment;
  List<Color> colors;
  final VoidCallback? onTap;
  AssignmentCard({super.key, required this.assignment, this.colors =const [Color(0xff18d092), Color(0xff400cd0)], this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 6),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 370,
            height: 95,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors, // Change to desired colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              color: Colors.transparent, // Make the card transparent to show gradient
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      assignment!.done! ? Icons.check_circle_outline_sharp : Icons.circle_outlined,  // Replace with desired icon
                      size: 28,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        assignment?.title ?? 'No Title', // Replace with desired text
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontSize: 17,
                          color: Colors.white,
                          decoration: assignment!.done! ? TextDecoration.lineThrough : TextDecoration.none,
                          decorationThickness: assignment!.done! ? 3 : 1, // Set thickness for line-through
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${assignment!.deadline!.hour < 10 ? '0' + assignment!.deadline!.hour.toString() : assignment!.deadline!.hour}:${assignment!.deadline!.minute < 10 ? '0' + assignment!.deadline!.minute.toString() : assignment!.deadline!.minute}', // Replace with desired text
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // This ensures the text doesn't overflow the row
                          ),
                          Text(
                            '${assignment!.deadline!.year}/${assignment!.deadline!.month}/${assignment!.deadline!.day}', // Replace with desired text
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontStyle: FontStyle.normal,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // This ensures the text doesn't overflow the row
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
