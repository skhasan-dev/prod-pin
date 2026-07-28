# ProdPin

Flutter app (mobile + web) for managing Pinterest posts generated from Amazon product listings.

## ⚠️ Important — build environment note

This project was generated in a sandbox **without the Flutter SDK or network access**, so none of
the following were run here:

- `flutter pub get`
- `dart run build_runner build --delete-conflicting-outputs` (needed for the Freezed models —
  `category.freezed.dart`, `category.g.dart`, `post.freezed.dart`, `post.g.dart` do **not exist
  yet** and must be generated)
- `flutter analyze` / `flutter run`

You'll need to do this on your own machine:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run          # or: flutter run -d chrome
```

Since the generated `.freezed.dart` / `.g.dart` files aren't included, the project **will not
compile** until you run `build_runner`.

## What's implemented

- Full directory structure exactly as specified in the build plan (`lib/src/common`, `config`,
  `core`, `features/category`, `features/pin`)
- Freezed models: `Category`, `Post` (with `@JsonKey` mappings for Mongo's `_id` and snake_case
  API fields)
- `CategoryProvider` / `PinProvider` — fully working with **dummy data** (4 categories, 24 posts),
  including filtering, add/update/delete, bulk delete, max-pins enforcement
- Dio-based data sources + repositories wired to the documented REST API, but **not called yet**
  (per the build plan — everything currently runs off dummy data in the providers)
- GoRouter navigation for all 7 routes
- Dark Pinterest-red theme
- All 7 screens: Home, Category Detail (with filters + max-pins banner), Add/Edit Category,
  Add/Edit Pin, Pin Detail (image carousel, overlay preview, tags, links)
- Responsive layout: list view on mobile, grid on tablet/desktop; row-of-icons pin actions on web,
  popup menu on mobile
- Common widgets: `ProdPinButton`, `ProdPinTextField`, `ProdPinLoader`, `EmptyStateWidget`,
  `TagChip`, `StatusBadge`/`ImageGenBadge`, `ImageUrlListField`
- `FilterBottomSheet`, `AffiliatedLinkDialog`

## Not implemented (matches "What's NOT Included" in the plan)

- Real API integration (swap dummy data in providers for the Dio repositories that are already
  wired up)
- Authentication
- AI image generation
- Pinterest API publishing
- Push notifications, offline support
- The optional web `NavigationRail` shell (only one destination — Home — currently exists, so it
  was left out; straightforward to add with a `ShellRoute` if you add more top-level destinations)

## Next steps

1. Copy `lib/` and `pubspec.yaml` into your existing `nomi` project (or use this as the project
   root if starting fresh).
2. `flutter pub get`
3. `dart run build_runner build --delete-conflicting-outputs`
4. `flutter run -d chrome` to see the web layout, or on a mobile simulator for the mobile layout.
5. Point `AppConstants.baseUrl` at your running Node backend and swap the provider dummy-data calls
   for the repository calls when you're ready to go live.
