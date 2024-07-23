import 'package:flutter/material.dart';
import 'package:food_recipe/data/data_source/chef/chef_api_fake.dart';
import 'package:food_recipe/data/data_source/recipe/recipe_api_fake.dart';
import 'package:food_recipe/data/model/recipe.dart';
import 'package:food_recipe/data/repository/chef/chef_repository_impl.dart';
import 'package:food_recipe/data/repository/ingredient/ingredient_repository_impl.dart';
import 'package:food_recipe/data/repository/procedure/procedure_repository_impl.dart';
import 'package:food_recipe/presentation/main_screen.dart';
import 'package:food_recipe/presentation/recipe_detail/recipe_detail_screen.dart';
import 'package:food_recipe/presentation/recipe_detail/recipe_detail_screen_view_model.dart';
import 'package:food_recipe/presentation/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/splash',
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen()),
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const MainScreen()),
      GoRoute(
        path: '/recipeDetail',
        builder: (BuildContext context, GoRouterState state) {
          final recipe = state.extra as Recipe;
          final recipeApi = RecipeApiFake();
          final chefApi = ChefApiFake();
          final ingredientRepository =
              IngredientRepositoryImpl(recipeApi: recipeApi);
          final procedureRepository =
              ProcedureRepositoryImpl(recipeApi: recipeApi);
          final chefRepository = ChefRepositoryImpl(chefApi: chefApi);
          final recipeDetailScreenViewModel = RecipeDetailScreenViewModel(
              ingredientRepository: ingredientRepository,
              procedureRepository: procedureRepository,
              chefRepository: chefRepository);
          return RecipeDetailScreen(
            recipe: recipe,
            viewModel: recipeDetailScreenViewModel,
          );
        },
      ),
    ],
  );
}
