import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../consts/emotions.dart';
import 'mood_note_tab.dart';

final emotionProvider = StateProvider<String?>((ref) => null);

class EmotionsPiker extends ConsumerWidget {
  const EmotionsPiker({super.key});

  static final List<String> _emotionsAll = emotions.keys.toList();

@override
  Widget build(BuildContext context, WidgetRef ref) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),

              for (var i = 0; i < _emotionsAll.length; ++i) ...{
                GestureDetector(
                  onTap: (){
                    if( ref.read(emotionProvider) == _emotionsAll[i] ){
                      ref.read(emotionProvider.notifier).state = null;
                    }
                    else {
                      ref.read(emotionProvider.notifier).state = _emotionsAll[i];
                    }
                    ref.read(feelingsProvider.notifier).state = [];
                  },
                  child: Container(

                      height: 157,
                      width: 110,
                      decoration: BoxDecoration(
                        border: ref.watch(emotionProvider)==_emotionsAll[i]? Border.all(color: Theme.of(context).primaryColor,width: 3): null,
                        borderRadius: BorderRadius.circular(76),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 240, 240, 240),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: Offset(0, 5), // shadow direction: bottom
                          )
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/z${i+1}.png',scale: 1.5,),
                          Text(_emotionsAll[i],style: const TextStyle(
                            fontSize: 15, color: Color(0xff4C4C69)),
                            softWrap: false,
                            overflow: TextOverflow.visible
                          )],
                      )
                  ),
                ),
                const SizedBox(width: 8), //между карточками
              },
              const SizedBox(width: 2), //доп.отступ послед. карточки
            ],),
          const SizedBox(height: 15),
        ],)
      );
  }
}
