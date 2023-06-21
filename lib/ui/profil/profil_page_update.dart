import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisisel_butce_yonetimi/ui/profil/provider/profil_page_provider.dart';

import '../../utils/color.dart';
import '../components/snackbar.dart';

class ProfilPageUpdate extends ConsumerWidget {
  static const String route = "/profil";
  const ProfilPageUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    final provider = updateUserViewModelProvider;
    final model = ref.read(updateUserViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profili Düzenle"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Consumer(
            builder: (context,ref,child) {
              ref.watch(provider);
              return MaterialButton(
                padding: EdgeInsets.all(16),
                color: kmavi,
                onPressed: model.enabled?() async{
                  try{
                    await model.write();
                    Navigator.pop(context);
                  } catch(e){
                    AppSnackbar(context).error(e);
                  }
                }:null,
                child: Text("Kaydet"),
              );
            }
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                final picked =
                await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  model.file = File(picked.path);
                }
              },
              child: Consumer(
                  builder: ( context,  ref, child) {
                    ref.watch(provider.select((value) => value.file));

                    return Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                          image: model.file != null || model.image != null
                              ? DecorationImage(
                              fit: BoxFit.cover,
                              image: model.file != null
                                  ? FileImage(model.file!) as ImageProvider
                                  : NetworkImage(model.image!))
                              : null),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (model.image != null && model.file == null)
                            Expanded(
                                child: Center(
                                    child: Icon(Icons.photo,
                                        color: scheme.onPrimaryContainer))),
                          Material(
                            color: theme.cardColor.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "resim seç".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: style.bodySmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              initialValue: model.name,
              textCapitalization: TextCapitalization
                  .sentences, // cümleleri büyük harfle başlatıyo
              decoration: InputDecoration(
                labelText: "Ad",
              ),
              onChanged: (v) => model.name = v,
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,//klavyede tik yapıyo
              initialValue: model.surname,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Soyad",
              ),
              onChanged: (v) => model.surname = v,
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
