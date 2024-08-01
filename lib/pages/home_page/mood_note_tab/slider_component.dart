import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'emotions_piker.dart';

class SliderComponent extends ConsumerWidget {
  const SliderComponent({required this.provider,this.lableLeft,this.lableRight , super.key});
  final StateProvider<int> provider;
  final String? lableLeft;
  final String? lableRight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value = ref.watch(provider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(210, 210, 210, 1.0),
            blurRadius: 10.0,
            spreadRadius: -8.0,
            offset: Offset(10, 10), // shadow direction: bottom
          )
        ],
      ),
      child: Column(
        children: [
          Slider(
            value: value.toDouble(),
            onChanged: ref.watch(emotionProvider)!=null?(v)=> ref.read(provider.notifier).state = v.toInt():null,
            max: 10,
            divisions: 10,label: value.toString(),thumbColor: Colors.lightBlue[900]
          ),//   Red(100) Blue(255) Green(70),

          if (lableLeft!=null || lableRight!=null)
              Padding(
                padding: const EdgeInsets.only(left: 24,right: 24, bottom: 10),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  Text(lableLeft??''),
                  Text(lableRight??''),
                ],),
              )
        ]),
    );
  }
}
