import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/custom_image.dart';

class CompletedCourse extends StatelessWidget {
  const CompletedCourse({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImage(
            data.image,
            // data["image"],
            radius: 15,
            height: 80,
          ),
          const SizedBox(
            width: 10,
          ),
          _buildInfo()
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Completed',
          style:
              TextStyle(fontSize: 14, color: Color.fromARGB(255, 53, 211, 32)),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildDurationAndRate()
      ],
    );
  }

  Widget _buildDurationAndRate() {
    return Row(
      children: [
        Icon(
          Icons.schedule_rounded,
          color: AppColor.labelColor,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          // data["duration"],
          data.duration,
          style: TextStyle(
            fontSize: 12,
            color: AppColor.labelColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Icon(
          Icons.star,
          color: AppColor.orange,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          // data["review"],
          data.review,
          style: TextStyle(
            fontSize: 12,
            color: AppColor.labelColor,
          ),
        )
      ],
    );
  }
}
