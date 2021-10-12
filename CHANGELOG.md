# Changelog - Ultima IV Remastered for Apple II

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Source code may be found at
https://github.com/sean-gugler/u4remasteredA2


## [1.2.2] - 2021-10-11

### Fixed
- Restored missing header file apple_detect.i


## [1.2.1] - 2021-09-08

### Fixed
- Dismounting horse in certain townes causes a random NPC to vanish.
- Chests dropped by townespeople can be talked to.

### Added
- [Issue #6] Support IIgs with Mockingboard cards.
- Support slotted Mockingboard model 4C on Apple //c


## [1.2.0] - 2021-08-19

### Fixed
- [Issue #5] Trainer for fair price buy-back was broken since 1.1.0
- Trainer for teleport could spawn unwanted phantom monsters.
- Trainer menu was missing item for towne exit.
- Trainer menu allows up and down arrow keys for machines that have them.
- Trainer menu clears selection indicator when leaving the menu to start the game.
- Music initialization clears all channel data, not just first 3.
- Saved game compatibility fixed for balloon flying state.

### Added
- Slideshow disk of in-game artwork, including tile sets.
- Ability to build with Docker.
- Proper descriptions for non-human NPCs instead of "phantom".
- Campfire NPC remains stationary in combat and spits fire.
- Ctrl+V turns music on and off during play, if Mockingboard was activated in pre-game Options menu.

### Changed
- Cleaned up some source code, finished symbolicating all of it.
- Moved built disk images into 'output' folder.


## [1.1.0] - 2021-07-03

### Added
- Trainer (cheat codes)
- Neutral gender option
- Quit-&-save in dungeon


## [1.0.1] - 2021-06-19

### Fixed
- [Issue 3] Freeze early during the new game sequence.


## [1.0.0] - 2021-06-18

### Added
- First public release.

#### Branch: "documented"
- Partially-documented assembly source, reconstructed from retail binary files.

#### Branch: "fixed"
- Fixes for all known bugs plus textual errors.
