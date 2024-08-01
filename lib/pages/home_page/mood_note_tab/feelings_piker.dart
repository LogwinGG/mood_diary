import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../consts/emotions.dart';
import 'emotions_piker.dart';
import 'mood_note_tab.dart';


class FeelingsPiker extends ConsumerStatefulWidget {
  const FeelingsPiker({super.key});

  @override
  ConsumerState<FeelingsPiker> createState() => _FeelingsPikerState();
}

class _FeelingsPikerState extends ConsumerState<FeelingsPiker> {
@override
  Widget build(BuildContext context) {
    List<String> feelings = emotions['${ref.watch(emotionProvider)}']!;
    List<String> selectF = ref.watch(feelingsProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Wrap(
        spacing: 10,
        children: feelings.map((item){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(210, 210, 210, 1.0),
                  blurRadius: 10.0,
                  spreadRadius: -10.0,
                  offset: Offset(6, 6), // shadow direction: bottom
                )
              ],
            ),
            child: FilterChip(
                label: Text(item, style: selectF.contains(item)? const TextStyle(color:  Colors.white):null,),
                selected: selectF.contains(item),
                onSelected: (bool selected){
                  setState(() {
                    selected? ref.read(feelingsProvider.notifier).update((state) => [...state, item])
                        :ref.read(feelingsProvider.notifier).update((state) { state.remove(item); return [...state];});
                  });
                },
                selectedColor: Theme.of(context).primaryColor,
                side: BorderSide.none,showCheckmark: false,


            ),
          );
        }).toList()
        ,
      ),
    );
  }
}
