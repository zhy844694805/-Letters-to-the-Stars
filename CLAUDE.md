# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**回响 (Huixiang)** is a memorial app for remembering deceased loved ones and pets. The app uses a starry sky theme where each memorial is represented as a glowing star in a night sky constellation.

## Development Commands

### Running the App
```bash
cd huixiang
flutter run -d <device_id>
```

**Common device targets:**
- iOS Simulator: `flutter run -d apple_ios_simulator` or use specific device ID
- macOS: `flutter run -d macos`
- Chrome: `flutter run -d chrome`
- List available devices: `flutter devices`

### Hot Reload
When the app is running:
- Press `r` for hot reload (fast UI updates)
- Press `R` for hot restart (full app restart)
- Press `q` to quit

### Building
```bash
# iOS
flutter build ios

# Android
flutter build apk

# macOS
flutter build macos
```

### Dependencies
```bash
# Get dependencies
flutter pub get

# Update dependencies
flutter pub upgrade

# Check for outdated packages
flutter pub outdated
```

## Architecture

### Application Structure

The app uses a **single-page architecture** with the starry sky theme as the main (and currently only) page.

**Entry point:** `lib/main.dart`
- Minimal setup that launches `StarrySkyPage` as the home screen
- Uses dark theme with deep blue-black background (#0A1128)

**Main page:** `lib/starry_sky_page.dart`
- Contains all UI and logic for the starry sky memorial interface
- Self-contained StatefulWidget with no navigation to other screens

**Backup:** `lib/garden_theme_backup.dart`
- Contains the previous "natural garden" theme implementation
- Not used in the current app but kept for reference
- Features card-grid layout with flower decorations

### Data Model

**Memorial class** (defined in `starry_sky_page.dart`)
- Represents a deceased person or pet
- Key fields:
  - `name`: Display name
  - `type`: Either 'person' or 'pet'
  - `date`: Life span dates
  - `accentColor`: Unique color for the star
  - `position`: Offset coordinates (0.0-1.0) for star placement on screen
  - `imageUrl`: Optional photo (currently unused)

**Data storage:** Currently uses hardcoded sample data in `_allMemorials` list. No persistence layer implemented yet.

### UI Components

**Starry Sky Theme:**
1. **Background:** 3-layer gradient (deep blue-black → deep blue → blue-gray) with 100 twinkling background stars
2. **Memorial Stars:** Each memorial is a colored circle with:
   - Pulsing glow animation (breathing effect)
   - Vertical floating animation
   - Icon indicator (person/pet)
   - Name label below
3. **Constellation Lines:** Automatically drawn between nearby stars (< 200px distance)
4. **Statistics Card:** Semi-transparent card showing total/person/pet counts
5. **Filter Chips:** Toggle between all/person/pet memorials
6. **FAB:** "点亮星星" (Light a Star) button for adding new memorials

### Animation System

Uses `TickerProviderStateMixin` with two animation controllers:

1. **_twinkleController** (2 seconds, repeating)
   - Controls star glow pulsing effect
   - Affects both memorial stars and background stars

2. **_floatController** (3 seconds, repeating)
   - Controls vertical floating motion of memorial stars
   - Creates gentle up-down movement

### Custom Painters

**BackgroundStarsPainter:**
- Renders 100 random background stars
- Uses fixed seed (42) for consistent star positions
- Stars twinkle based on animation value

**ConstellationPainter:**
- Draws connecting lines between nearby memorial stars
- Only connects stars within 200px distance
- Creates constellation effect

## Design Philosophy

**Visual Theme:** The starry sky represents eternal memory and hope. Each star symbolizes a life that continues to shine in memory.

**Color Palette:**
- Background: Deep space blues (#0A1128, #1E2749, #2E3856)
- Star colors: Warm tones (gold #FFD700, orange #FFA500) for people, cool tones (sky blue #87CEEB, light green #98FB98) for pets
- UI elements: Semi-transparent white with subtle borders

**Interaction Model:**
- Tap star → View memorial details (placeholder dialog)
- Tap FAB → Add new memorial (placeholder dialog)
- Filter chips → Show/hide memorial types

## Future Development Areas

Based on current placeholder implementations:

1. **Data Persistence:** Need to implement local storage (e.g., SQLite, Hive) or cloud sync
2. **Memorial Details Page:** Currently shows placeholder dialog, needs full detail screen
3. **Add Memorial Flow:** Multi-step form to create new memorials with photo upload
4. **Photo Integration:** `imageUrl` field exists but not displayed
5. **Edit/Delete:** No UI for modifying existing memorials
6. **Search:** Filter chips exist, but no text search functionality

## Code Style Notes

- Chinese comments and UI text (app targets Chinese-speaking users)
- Heavy use of `const` constructors for performance
- Material 3 design system
- Custom animations over pre-built transitions
- All colors defined inline (no separate theme/constants file)
