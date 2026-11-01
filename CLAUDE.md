# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

CountDown is a SwiftUI iOS hangboard training app (iOS 16.2+) for building and running custom hangboard workouts made of grips, with workout history. Licensed AGPL; published on the App Store.

## Commands

Single Xcode project (`CountDown.xcodeproj`), one scheme `CountDown`, targets `CountDown`, `CountDownTests`, `CountDownUITests`. Dependencies are Swift packages (ViewInspector for view tests, Starling, Popovers, ExceptionCatcher) resolved by Xcode.

```sh
# Build
xcodebuild -project CountDown.xcodeproj -scheme CountDown -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build

# All tests (unit + UI)
xcodebuild -project CountDown.xcodeproj -scheme CountDown -destination 'platform=iOS Simulator,name=iPhone 15 Pro' test

# Single test class / method
xcodebuild ... test -only-testing:CountDownTests/WorkoutViewModelTests
xcodebuild ... test -only-testing:CountDownTests/WorkoutViewModelTests/testNewWorkoutCreatedCorrectly

# Same lane CI uses
bundle exec fastlane ios tests
```

CI (`.github/workflows/ios_fastlane.yml`) runs `fastlane ios tests` on PRs/pushes to `main`; pushes to `main` then run `build_upload_testflight` (auto-increments build number from TestFlight). There is no linter configured.

## Architecture

- **Persistence: Core Data**, model at `CountDown/CoreData/CountDown.xcdatamodeld`. Entity classes (`Workout`, `Grip`, `GripType`, `WorkoutType`, `WorkoutHistory`, `HistoryGrip`) are manually generated `+CoreDataClass`/`+CoreDataProperties` files; properties files add `unwrapped*` computed accessors (e.g. `unwrappedName`) that views and view models use instead of raw optionals. Adding an attribute means updating the model *and* the properties file. `History*` entities are snapshots of a workout/grip at completion time, separate from the editable `Workout`/`Grip`.
- **`PersistenceController`** provides `shared`, `preview` (sample data for SwiftUI previews), and in-memory `unitTestEmpty` / `unitTestPreloadWorkout`. `CountDownApp` picks the in-memory ones when launched with `UI-Testing-Empty` or `UI-Testing-Preload-Workout` arguments (used by UI tests). The context is injected via `\.managedObjectContext`; changes are saved on scene phase change.
- **View models** (`CountDown/ViewModels`) are value-type structs (`WorkoutViewModel`, `GripViewModel`, `WorkoutHistoryViewModel`) holding editable form state plus an `NSManagedObjectContext`; `save()` creates or updates the backing managed object. `ErrorMessages` provides form validation.
- **Timer engine**: `GripsArray` (`Models/GripsArray.swift`) flattens a workout's grips into a sequence of `DurationStatus` entries per grip (work/rest/switch/break/prepare), including left/right-hand mode (`isLeftRightEnabled`, `startHand`, `secondsBetweenHands`) and custom per-rep durations. `CountdownTimer` (`@MainActor ObservableObject`) walks that sequence via `gripIndex`/`durationIndex`, drives the `TimerState` machine, plays sounds/vibration (`TimerSoundPlayer`, `TimerVibrator`; sound files in `Resources/*.caf` with high/low variants), and toggles idle-sleep. The ad-hoc timer builds a `GripsArray` from a single `GripViewModel`.
- **User settings** use `@AppStorage` keys (`isDarkMode`, `soundType`, `timerSound`, `timerVibration`).
- Audio session is `.ambient` so timer sounds mix with other apps' audio.

## Tests

Unit tests in `CountDownTests` mirror the app folders (CoreData, Models, Utilities, ViewModels, Views). Tests build a fresh context with `PersistenceController(inMemory: true).container.viewContext`. View tests use ViewInspector.

`CountDownWidgets/` and `Shared/` are empty/unused.
