import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

final translator = GoogleTranslator();

class TranslatorTestPage extends HookWidget {
  const TranslatorTestPage({super.key});

  Future<String?> sendTranslator(String inputValue) async {
    final res = await translator.translate(
      inputValue,
      from: 'auto',
      to: 'zh-cn',
    );
    i(res);
    return res.text;
    // translator.translate(input2, from: 'auto', to: 'zh-cn').then(print);
  }

  @override
  Widget build(BuildContext context) {
    final input = useState('');
    final text = useState('');
    return Scaffold(
      appBar: AppBar(
        title: const Text('翻译测试'),
      ),
      // body: SingleChildScrollView(child: Text(str)),
      body: Column(
        children: [
          ElInput(
            value: input.value,
            onChanged: (v) => input.value = v,
          ),
          Text('文本内容：${input.value}'),
          Text('翻译结果：${text.value}'),
          ElButton(
            onPressed: () async {
              final str = await sendTranslator(input.value);
              if (str != null) {
                text.value = str;
              }
            },
            child: '翻译',
          ),
        ],
      ),
    );
  }
}


String str = '''
Readme
Changelog
Example
Installing
Versions
Scores
auto_localized 
auto_localized is simplifying Flutter localization by using code generation. This approach has many advantages such as runtime-safety and better performance. The generator checks translation files for missing keys, blank values etc. and outputs easy to use dart fields (or methods).

Supported file types: JSON, YAML.

Generation time validation
Get translations without BuildContext
Safe Arguments
Supported file types: JSON, YAML
Getting Started 
Native setup 
On iOS you need to add supported locales to ios/Runner/Info.plist

Example:

<key>CFBundleLocalizations</key>
<array>
  <string>pl</string>
  <string>en</string>
  <string>sk</string>
</array>
Pubspec setup 
Add dependencies to your pubspec.yaml:

dependencies:
  auto_localized: <latest_version>

dev_dependencies:
  build_runner: <latest_version>
  auto_localized_generator: <latest_version>
Note: no need for adding flutter_localizations dependency: auto_localized does it for you.

If you store your translations files outside of lib folder (which you should), example structure:

lang/
├── en.yaml
├── pl.json
└── sk.json
lib/
build.yaml
pubspec.yaml
you need to tell build_runner about that, by overriding default sources (by default you can reference a file only from lib directory). Create new (or update existing) build.yaml file on the root of the project and add following section:

targets:
  \$default:
    sources:
      - \$package\$
      - lib/**
      - lang/**  # <-- your translations directory 
You can checkout sample configuration in the example.

Note: Adding translations directory to assets section in pubspec.yaml is not required. Flutter don't need these files at runtime.

Configuration 
Create new dart file with empty class and annotate it with AutoLocalized.

Example:

import 'package:auto_localized/annotations.dart';

@AutoLocalized(
  locales: [
    AutoLocalizedLocale(
      languageCode: 'pl',
      translationsFiles: ['lang/pl.json'],
    ),
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      translationsFiles: ['lang/en.json'],
    ),
    AutoLocalizedLocale(
      languageCode: 'sk',
      translationsFiles: ['lang/sk.json'],
    ),
  ],
)
class \$Strings {}
Important: path to translation file must be relative. Class name have to start with \$. Name of that class will be used as name of translation container class - for the example above it will be: Strings.

Generation 
Run the generator with command in terminal:

flutter pub run build_runner build --delete-conflicting-outputs
Build can run automatically after every file change with:

flutter pub run build_runner watch --delete-conflicting-outputs
Usage 
In app declaration add generated config fields: supportedLocales and localizationsDelegates. Also, if you want to get translations without context you need to wrap MaterialApp with AutoLocalizedApp:

return AutoLocalizedApp(
  child: MaterialApp(
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationsDelegates,
  ),
);
You can access these fields by AutoLocalizedData class or AutoLocalizedContextExtension.

Done! 
Translations are ready to use by:

Text(
  Strings.welcome.get(context),
)
you can also get translations without context:

Text(
  Strings.welcome.get(),
)
BuildContext extension is also here:

Text(
  context.translate(Strings.welcome),
)
If you enable generateGetterMethods in annotation config you will get two additional ways:

//getter method
Text(
  Strings.getWelcome();
)

//BuildContext extension
Text(
  context.getWelcome();
)
Example 
For typical complete setup checkout example.

Features 
Safe Arguments 
You can define up to 5 arguments in for your translations, to define argument use syntax: {(number from 1 to 5)} for example:

{
  "welcome_message" : "Welcome {1}!, You have {2} points."
}
Result:

Strings.welcomeMessage('Marcin', '3');
Note: These arguments are required - The compiler will force you to pass these arguments.

You can also get args translation without applying them with getRaw() method.

Argument with given number can be used as much as you want, example:

{
  "distance" : "Traveled: {2} {1} - Distance: {3} {1}"
}
You can get value for arg string with:

Strings.distance.get('km', '12', '30');
If you enable generateGetterMethods in annotation config you will get two additional ways:

//getter method
Strings.getDistance('km', '12', '30');

//BuildContext extension
context.getDistance('km', '12', '30');
There is also regular translate BuildContext extension method:
''';