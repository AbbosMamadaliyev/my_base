import 'package:flutter/material.dart';
import 'package:my_base/ui/view_data_page/view_data_page_model.dart';
import 'package:provider/provider.dart';

import '../../home_page/home_page_model.dart';

class TitleDataWidget extends StatelessWidget {
  final int index;

  const TitleDataWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = context.watch<HomePageModel>().titles;
    final title = titles[index].title;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '---  $title',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete item'),
                        content: const Text('Rostan o\'chirmoqchimisiz?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('no'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<ViewDataPageModel>()
                                  .deleteItem(titles[index].id!);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Deleted item'),
                                  backgroundColor: Colors.red,
                                ),
                              );

                              Navigator.of(context).pop();
                            },
                            child: const Text('yes'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
