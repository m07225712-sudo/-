import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/database/app_database.dart';
import '../../data/repository/app_repository.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final AppRepository repository;

  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> loadCategories() async {
    emit(CategoryLoading());
    try {
      final list = await repository.fetchCategories();
      emit(CategoryLoaded(list));
    } catch (e) {
      emit(CategoryError('Не удалось загрузить категории'));
    }
  }

  Future<void> addCategory(String name, String icon) async {
    try {
      await repository.addCategory(name, icon);
      await loadCategories();
    } catch (e) {
      emit(CategoryError('Не удалось добавить категорию'));
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      await repository.updateCategory(category);
      await loadCategories();
    } catch (e) {
      emit(CategoryError('Не удалось изменить категорию'));
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await repository.deleteCategory(id);
      await loadCategories();
    } catch (e) {
      emit(CategoryError('Не удалось удалить категорию'));
    }
  }
}
