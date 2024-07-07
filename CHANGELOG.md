# Changelog - Ultima IV Remastered for Apple II

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Source code may be found at
https://github.com/sean-gugler/u4remasteredA2


## [1.2.11] - 2024-07-06

### Fixed
- [Issue #18] Pressing T during startup was timing-sensitive, didn't work when spamming the keypress.


## [1.2.10] - 2024-01-13

### Fixed
- [Issue #17] Calabrini's dialogue keyword changed from "HEALING" to "INJURED" because it was masking "HEALTH".


## [1.2.9] - 2023-11-27

### Fixed
- View spell or peering gem does not fully draw Level 5 in Wrong. (Doubled size of search tree and changed from depth-first to breadth-first.)

### Added
- [Issue #16] Disassembly of TMAP file.


## [1.2.8] - 2022-11-25

### Fixed
- [Issue #15] After donating blood, healer's name always became "Pendragon".


## [1.2.7] - 2022-08-01

### Fixed
- Ghost and Zorn would not move onto swamp (regression since 1.2.0).
- Dungeon monster AI mistakenly rejects moving south as if trying to return north (regression since 1.2.0). Not always noticeable since it has 1/8 chance of allowing return to previous position anyway, and makes 8 movement attempts per turn.


## [1.2.6] - 2021-12-06

### Fixed
- [Issue #8] Gold amount actually awarded matches printed amount. (Regression)


## [1.2.5] - 2021-11-06

Restore apparently publisher-authentic fixes discovered in "Ultima4_original.zip" contributed 2005 by "Marvin".

### Fixed
- Lord British says Moonglow is on the wrong island.
- The conversational response to "LOOK" has a redundant word.

### Changed
- Player starting positions in Hythloth room 7 revised to match official edition.


## [1.2.4] - 2021-10-23

### Fixed
- Two ladders in dungeon "Wrong" are mis-matched.
- Dungeon "Covetous" has a room whose east exit is obstructed.
- Cooldown timer for Hawkwind's virtue reward should match timer for shrine.
- Cooldown timer for reagent searches should not reset when search finds non-reagents.


## [1.2.2] - 2021-10-12

### Fixed
- Restored missing header file apple_detect.i
- Fix Makefile for compatibility with both Gnu Make 4.2 and 4.3


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
