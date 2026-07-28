import 'package:get_it/get_it.dart';
import 'package:prod_pin/src/common/index.dart' show ThemeProvider;
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/category/index.dart'
    show
        AddCategoryViewModel,
        CategoryDataSource,
        CategoryDataSourceImpl,
        CategoryRepository,
        CategoryRepositoryImpl,
        CategoryViewModel,
        EditCategoryViewModel;
import 'package:prod_pin/src/features/pin/index.dart'
    show PinDataSource, PinDataSourceImpl, PinRepository, PinRepositoryImpl;
import 'package:prod_pin/src/features/pin/presentation/view_model/index.dart';

final getIt = GetIt.instance;

void initDependencyLocator() {
  getIt
    ..registerLazySingleton<ThemeProvider>(() => ThemeProvider())
    ..registerLazySingleton<NetworkService>(() => NetworkService())
    ..registerLazySingleton<CategoryDataSource>(
      () => CategoryDataSourceImpl(networkService: getIt()),
    )
    ..registerLazySingleton<PinDataSource>(
      () => PinDataSourceImpl(networkService: getIt()),
    )
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(dataSource: getIt()),
    )
    ..registerLazySingleton<PinRepository>(
      () => PinRepositoryImpl(dataSource: getIt()),
    )
    ..registerFactory<CategoryViewModel>(
      () => CategoryViewModel(repository: getIt()),
    )
    ..registerFactory<AddCategoryViewModel>(
      () => AddCategoryViewModel(repository: getIt()),
    )
    ..registerFactory<EditCategoryViewModel>(
      () => EditCategoryViewModel(repository: getIt()),
    )
    ..registerFactory<PinsViewModel>(
      () => PinsViewModel(repository: getIt()),
    )
    ..registerFactory<PinDetailViewModel>(
      () => PinDetailViewModel(repository: getIt()),
    )
    ..registerFactory<AddPinViewModel>(
      () => AddPinViewModel(repository: getIt()),
    )
    ..registerFactory<EditPinViewModel>(
      () => EditPinViewModel(repository: getIt()),
    );
}
