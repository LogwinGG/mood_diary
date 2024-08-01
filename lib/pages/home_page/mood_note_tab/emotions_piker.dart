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
              const SizedBox(width: 15),

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
                      height: 140,
                      width: 94,
                      decoration: BoxDecoration(
                        border: ref.watch(emotionProvider)==_emotionsAll[i]? Border.all(color: Theme.of(context).primaryColor,width: 2): null,
                        borderRadius: BorderRadius.circular(70),
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
                          Image.asset('assets/images/h${i+1}.webp',scale: 5,),
                          Text(_emotionsAll[i] ,style: const TextStyle(fontSize: 12,color: Color.fromRGBO(21, 37, 79, 1.0))
                          )],
                      )
                  ),
                ),
                const SizedBox(width: 10), //между карточками
              },
              const SizedBox(width: 5), //доп.отступ послед. карточки
            ],),
          const SizedBox(height: 15),
        ],)
      );
  }
}
