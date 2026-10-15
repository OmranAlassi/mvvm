# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get                 # install dependencies
flutter run                     # run the app (add -d <device> to pick a target)
flutter analyze                 # lint (flutter_lints; platform folders and build/ are excluded)
flutter test                    # run all tests
flutter test test/widget_test.dart                 # run one test file
flutter test --plain-name "<test name>"            # run a single test by name
```

Note: [test/widget_test.dart](test/widget_test.dart) is still the default Flutter counter template and does not match the app; it will fail. `MyApp` also depends on `injection_container.init()` having run, so widget tests that pump `MyApp` must call `await sl.init()` (and mock `SharedPreferences` via `SharedPreferences.setMockInitialValues({})`) first.

The Dart SDK constraint is `^3.13.3`; the code uses recent syntax such as dot-shorthand constructors (`= .new()`) and `const new({super.key})`.

## Architecture

Flutter app organized as feature-first MVVM, with Cubits (flutter_bloc) acting as the ViewModel.

**Request flow:** Screen → Cubit → Repo (abstract + `Impl`) → `ApiConsumer` → Dio.

- **DI** — [lib/injection_container.dart](lib/injection_container.dart) registers everything on a global `GetIt` instance `sl`. `main()` awaits `sl.init()` before `runApp`. Cubits are `registerFactory`; repos, `CacheHelper`, `ApiConsumer`, interceptors and `Dio` are lazy singletons. Every new cubit/repo must be registered here.
- **Routing** — [lib/core/routes/app_route.dart](lib/core/routes/app_route.dart) defines a static `GoRouter`; path strings live in `AppRouteConst`. Cubits are provided per-route by wrapping the screen in `BlocProvider(create: (_) => sl<XCubit>())` inside the `GoRoute` builder, not globally.
- **Networking** — `ApiConsumer` ([lib/core/service/api_consumer.dart](lib/core/service/api_consumer.dart)) is the abstraction; `DioConsumer` implements it, sets `EndPoint.baseUrl`, and attaches `ApiInterceptor` + `LogInterceptor` from `sl`. Methods return `response.data` (dynamic). `isFormData: true` wraps the body in `FormData`.
- **Auth headers** — `ApiInterceptor` sets JSON headers, `Accept-Language: ar`, and a `Bearer` token read from `CacheHelper` under key `ApiKey.token`. Nothing currently saves the token after login, so persisting it via `sl<CacheHelper>().saveData(key: ApiKey.token, ...)` is required for authenticated calls.
- **Errors** — `DioConsumer` catches `DioException` and calls `handleDioExceptions` ([lib/core/errors/exceptions.dart](lib/core/errors/exceptions.dart)), which always throws `ServerException` carrying an `ErrorModel` with a user-facing message (server `message` field if present, otherwise a status/timeout-specific fallback). Repos catch `ServerException` and return `Either<String, Model>` (dartz) — `Left` is the error message. Cubits `fold` the result into Error/Success states.
- **Constants** — endpoint paths and JSON/header keys are in [lib/core/const/end_point.dart](lib/core/const/end_point.dart) (`EndPoint`, `ApiKey`); models parse JSON using `ApiKey` constants rather than string literals.

### Feature layout

```
lib/features/<feature>/[<sub-feature>/]
  data/models/          # fromJson models
  data/repo/            # <x>_repo.dart (abstract) + <x>_repo_impl.dart
  manger/cubit/         # <x>_cubit.dart + <x>_state.dart (part file; sealed Equatable states)
  presentation/screens/
```

Note the folder is spelled `manger` (not `manager`); keep that spelling for consistency with existing imports. Shared widgets (`AppSnackBar`, `AppTextFormfield`) are in [lib/common/widgets/](lib/common/widgets/); form validators in [lib/core/utils/validators.dart](lib/core/utils/validators.dart). Screens use `BlocConsumer`: the listener shows `AppSnackBar` and navigates; the builder swaps in a loader on the Loading state.
