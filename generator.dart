// ignore_for_file: avoid_print

import 'dart:io';

import 'generator_helper.dart';
import 'generator_module.dart';

String rootPath = "lib/";
String modulesPath = "${rootPath}features/";

void main(List arguments) {
  print(
    '\n----------------------Choose--------------------------\n'
    '0. Membuat Fitur (Cubit)\n'
    '------------------------------------------------------\n',
  );

  print('Masukkan Index : ');
  final resInput = InputUser.input();
  if (!['0'].contains(resInput)) {
    print('Index yang kamu inputkan salah!');
    return;
  }

  switch (resInput) {
    case '0':
      Generate.createFeature();
    default:
  }
}

class Generate {
  static void createFeature() async {
    print('Inputkan Nama Fitur : (Format UpperCamelCase Contoh: Todo, User)');
    final featureNameInput = stdin.readLineSync();
    if (featureNameInput == null || featureNameInput.trim().isEmpty) {
      print('Nama Fitur tidak boleh kosong!');
      return;
    }

    final featureName = DataConverter.camelCaseToPascalCase(
      featureNameInput.trim(),
    );
    final snake = DataConverter.camelCaseToSnakeCase(featureName);

    // FEATURE-LOCAL STRUCTURE
    final featureRoot = '$modulesPath$snake/';

    // DOMAIN
    final domainEntities = '${featureRoot}domain/entities/';
    final domainRepositories = '${featureRoot}domain/repositories/';
    final domainUsecases = '${featureRoot}domain/usecases/';

    await file(
      name: '$domainEntities${snake}_entity.dart',
      content: GeneratorModuleData.entity(nameFeature: featureName),
    );
    await file(
      name: '$domainRepositories${snake}_repository.dart',
      content: GeneratorModuleData.repositoryInterface(
        nameFeature: featureName,
      ),
    );
    await file(
      name: '${domainUsecases}get_${snake}_list_usecase.dart',
      content: GeneratorModuleData.usecaseGetList(nameFeature: featureName),
    );

    // DATA
    final dataDatasources = '${featureRoot}data/datasources/';
    final dataRepositories = '${featureRoot}data/repositories/';
    final dataModels = '${featureRoot}data/models/';

    await file(name: '$dataModels.gitkeep');
    await file(
      name: '$dataDatasources${snake}_remote_datasource.dart',
      content: GeneratorModuleData.dataSource(nameFeature: featureName),
    );
    await file(
      name: '$dataRepositories${snake}_repository_impl.dart',
      content: GeneratorModuleData.repositoryImpl(nameFeature: featureName),
    );

    // PRESENTATION (Cubit)
    final presentationCubit = '${featureRoot}presentation/cubit/';
    final presentationViews = '${featureRoot}presentation/views/';

    await file(
      name: '$presentationCubit${snake}_cubit.dart',
      content: GeneratorModuleData.cubit(nameFeature: featureName),
    );
    await file(
      name: '$presentationCubit${snake}_state.dart',
      content: GeneratorModuleData.cubitState(nameFeature: featureName),
    );
    await file(
      name: '$presentationViews${snake}_page.dart',
      content: GeneratorModuleData.page(nameFeature: featureName),
    );

    // DI
    final diDirectory = '${featureRoot}di/';
    await file(
      name: '$diDirectory${snake}_di.dart',
      content: GeneratorModuleData.di(nameFeature: featureName),
    );

    await _ensureRouteConstant(
      constantName: DataConverter.pascalCaseToCamelCase(featureName),
      routePath: '/$snake',
    );

    print(
      'Feature $featureName berhasil dibuat (Cubit) di folder lib/features/$snake. Jangan lupa panggil ${featureName}DI.inject() saat inisialisasi service locator.',
    );
  }

  static Future<void> file({required String name, String content = ''}) async {
    final temp = File(name);
    temp.createSync(recursive: true);
    if (content.isEmpty) return;
    temp.writeAsStringSync(content);
  }

  static Future<void> _ensureRouteConstant({
    required String constantName,
    required String routePath,
  }) async {
    final routesFile = File('${rootPath}configs/routes/route.dart');
    if (!routesFile.existsSync()) return;

    final content = routesFile.readAsStringSync();
    if (content.contains('static const String $constantName')) {
      return;
    }

    final insertion = "  static const String $constantName = '$routePath';\n";
    final insertIndex = content.lastIndexOf('}');
    if (insertIndex == -1) return;

    var before = content.substring(0, insertIndex);
    final after = content.substring(insertIndex);

    if (!before.endsWith('\n')) {
      before = '$before\n';
    }

    final updated = '$before$insertion$after';
    routesFile.writeAsStringSync(updated);
  }
}

class InputUser {
  static String input() {
    final result = stdin.readLineSync();
    if (result == null || result.isEmpty) {
      print('Inputan Tidak Boleh Kosong');
    }
    return result ?? '';
  }
}
