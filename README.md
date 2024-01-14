Ultima IV for Apple II, Remastered
==================================

Greetings, traveler! Here you will find the most bug-free edition of Ultima IV for the Apple II ever known. May you enjoy the experience such as it was always meant to be.

This is meant as a "transparent" mod, meaning that any deviations beyond bug fixes are *optional*. You will not see any "enhancements" unless you deliberately invoke them; you can play the game exactly as originally designed.

Download from:
https://github.com/sean-gugler/u4remasteredA2/releases

For more information:
https://github.com/sean-gugler/u4remasteredA2/wiki


Hidden Features
---------------

If you are running the pre-built disk images, or have built your own from the `fixed` branch of the source repository, the following options are available to you.

* During the initial loading screen, before the animated intro, press 'T' to see the "Trainer" menu and enable cheat codes.
* When asked "Art thou Male or Female?" you can answer 'N' (for "no" or "non-binary"). Your character's gender symbol will be a neutral circle in the "Ztats" screen.
* In dungeon rooms (and any combat), press digit keys 1 through 8 to make that player active. The others will auto-pass their turns. Press 0 to return to all-party mode.
* Ctrl+V turns music on and off during play, if Mockingboard was activated in pre-game Options menu.

### Trainers
* When "Control Balloon" is active, [K]limb a second time to drift normally. [D]escend back to steering height, then again to land.
* When using "Teleport" with "Ingame Keys", specify a Towne, Dungeon, or Shrine with a letter A-P (just like the observatory).
* The "Fair Resell Price" makes buy-back prices for all weapons and armor exactly half the purchase price.

### Slide shows

Two extra disk images have been included for fun. They are both bootable and contain ready-to-view artwork from within the game.
* slideshow_start.do has the title screen, "start new game" images, tile sets and font glyphs.
* slideshow_end.do has the end game image sequence.


FIXES MADE
----------
**KEY:**
- (M) = ported from MagerValp's fixes for C64
- (G) = fixed by Gugler, his own discovery
- (E) = fixed by Gugler, from external bug report

### Critical Bugs
- (M) Stack overflow if attacked by wandering monsters.
- (M) Stack overflow if attacked by bridge trolls.
- (M) Stack overflow if entire party is killed.
- (G) Stack overflow every moongate jump.
- (G) Stack overflow using Ztats during combat.
- (G) Stack overflow using Z-down spell at bottom of dungeon.
- (G) Stack underflow if characters attempt to take different exits from dungeon room.
- (G) Morning after inn wakes sleeping characters with invalid status 'A'.
- (G) Crash in healer if refuse to donate blood while elevated in sacrifice.
- (E) Stack overflow if kicked out of Codex.

### Other Errors
- (M) Some dungeon rooms lack proper entry placements.
- (M) Hythloth level 6 impassable if entered from below.
- (M) Boarding a ladder-up spawns a frigate on the surface.
- (M) Entering towne while in a balloon should not be allowed.
- (M) Lord British "HELP" repeats early-game text every 10,000 moves.
- (M) Thevel behaves as a regular "Joe", his valuable hints are inaccessible.
- (M) Shrines never give the 2- and 3-cycle hints.
- (M) Gate guards at Serpent's Hold behave as if they were Baron Sentri.
- (M) Chests dropped by townespeople can be attacked.
- (G) Chests dropped by townespeople can be talked to.
- (G) Cannot talk to the healer in Serpent's Hold castle.
- (G) Enemy strength for non-monsters was calculated wrong.
- (G) NPC questions worded as humility tests were not flagged to affect virtue.
- (G) Wrong virtue rewarded for donating gold.
- (G) Balloon can land on illegal terrain by quitting game and rebooting.
- (G) Player can be attacked by bridge trolls while drifting across in the balloon.
- (G) Completion of skull quest grants awards to wrong area of memory.
- (G) Using skull in dungeon only immobilizes wandering monsters, doesn't kill them.
- (G) Skull use in battlefield should affect combatants, not clear outer world of wandering monsters.
- (G) Skull cannot be used in *any* dungeon rooms; fixed to behave normally except in abyss, where it is disallowed entirely.
- (G) Packed image corrupted if header happens to end on page boundary (did not occur with retail alignment).
- (G) Mockingboard activation menu disables second card if first one is invalid.
- (G) New music doesn't fully initialize every channel.
- (G) Demo music silently overruns table until Mockingboard is activated.
- (G) Dismounting horse in certain townes causes a random NPC to vanish.
- (E) Two ladders in dungeon "Wrong" are mis-matched.
- (G) Dungeon "Covetous" has a room whose east exit is obstructed.
- (G) Cooldown timer for Hawkwind's virtue reward should match timer for shrine.
- (E) Cooldown timer for reagent searches should not reset when search finds non-reagents.
- (E) Calabrini's dialogue keywords should not alias each other, they must all be unique.

### Cosmetic Mistakes
- (M) Combat animations are erratic for certain types of foe.
- (M) Spelling, capitalization, and grammar.
- (G) Katrina prints both excuses if virtue is too low ("Thou art not humbleexperienced enough").
- (G) Ztats display of 3-part key is truncated if you have bell or book but not candle.
- (G) Ankh doesn't immediately update after attacking townsfolk and losing virtues.
- (E) Lord British says Moonglow is on the wrong island.
- (E) The conversational response to "LOOK" has a redundant word.
- (E) After donating blood, healer's name always becomes "Pendragon".
- (G) View spell or peering gem does not fully draw Level 5 in Wrong.

### Enhancements
- (M) Allow quit-&-save in dungeon.
- (M) Select an active character in combat for faster exploration in dungeon rooms.
- (M) Trainer menu to optionally enable cheat codes.
- (M) Trainers for free items.
- (M) Trainer to steer the balloon.
- (M) Trainer to avoid combat.
- (M) Trainer to enable rapid movement around the world.
- (M) Trainer to disable the idle "pass" timer.
- (M) Trainer to ask confirmation before exiting a towne.
- (G) Buy-back weapon at half price didn't carry the hundreds place (optional fix with trainer).
- (G) Library shelf lettering made one puzzle somewhat awkward.
- (G) Gender question did not support non-binary; add a neutral symbol.
- (G) Proper descriptions for non-human NPCs instead of "phantom".
- (G) Campfire NPC remains stationary in combat and spits fire.
- (G) Ctrl+V turns music on and off during play, if Mockingboard was activated in pre-game Options menu.
- (E) Support IIgs with Mockingboard cards.
- (G) Support slotted Mockingboard model 4C on Apple //c


Source Code
-----------

https://github.com/sean-gugler/u4remasteredA2

This source code has been reconstructed by disassembling and symbolicating the 1985 binary code released for Apple II series computers. It likely bears little resemblance to the original source, but it can be used by modern tools to build the same playable binaries.

All code has been symbolicated. Data layouts and values may be inferred from the header definitions, but the data itself is not included in this repository. It must be obtained from existing disk images.


Branches
---------

The branch "**fixed**" includes numerous bug fixes and spelling/grammar corrections, as well as some non-intrusive improvements upon the original game. New features are silent unless invoked, so players may choose to ignore them and experience the game as originally designed.

The branch "**documented**" can re-create binary code identical to the original. Some original bugs are noted in the source, but not fixed, in this branch. A curious visitor may diff the two branches to review exactly what was changed.


Building with Docker
--------------------

If you have Docker installed, checkout or download the `fixed` branch and run the following commands:

```
docker compose run u4remastera2 && docker compose rm -f && docker rmi u4remastereda2_u4remastera2:latest
```


Building without Docker
-----------------------

To build the source you need this software:

* [cc65](https://github.com/cc65/cc65) V2.19
* Python 3.6
* GNU Make 4.2

My development environment is Windows Subsystem for Linux, Ubuntu flavor ... although any Linux should do.

You also need disk images of Ultima IV for Apple II to import the graphics, maps, and other data that are not included in this git repository. I recommend using the de-protected images published by 4am.

* [Ultima IV at Archive.org](https://archive.org/details/UltimaIV4amCrack)

Rename those disk images and place them in the following locations:
```
files/original/u4britannia.do
files/original/u4program.do
files/original/u4towne.do
files/original/u4underworld.do
```
Type `make all` to produce rebuilt versions of those disk images in the root folder.


Reconstruction
--------------

If you're interested in following my footsteps and reconstructing source from the binaries, you'll also need:

* Python 3.8
* [Regenerator 1.7](https://csdb.dk/release/?id=149429)

Regenerator is a light-weight, portable Windows application. Install or copy it into the `regenerator` folder.

Extract the DOS 3.3 files from the original disks with the command `make extract`. This runs  `tools/extract_files.py` to populate the `files/extracted` folder. 

| **Tech Note:** Extracted files match the byte streams as stored in DOS 3.3, including the "load address" value (byte offsets 0 and 1) but minus the "file length" value (byte offsets 2 and 3) which is instead implicit in the file size. This is so the resulting .prg files are natively parseable by Regenerator. |

For each binary program file, I performed the following steps:
1. `tools/regen_config.py --labels regenerator/Config/ultima4_labels.txt files/extracted/{DISK}/{FILE}.prg regenerator/Config`
   This step is not strictly necessary, but it saves a lot of work. This script parses the binary file and creates a Config script for Regenerator. It is the same file Regenerator will create from scratch when you choose "Save", but pre-populated with known address symbols and auto-detected inline text regions.
2. Many of the program files embed an incorrect load address, ignored by the game because it specifies an explicit address with the `BLOAD FILE,A$nnnn` command. Presumably these addresses are an artifact of the original development process. For these files, use the `--addr` option; for example, `tools/regen_config.py --addr 8800 files/extracted/towne/USE.prg [...]`
3. Run the Regenerator app. Choose "Load" and open the .prg file. It will automatically load the config file you just created.
4. Review the program, using Regenerator features to assign sensible names to addresses.
5. Choose "Save" to both write the Config file and generate a `.tas` file. This is a text file usable as source code for the "TASS" assembler.
6. `tools/tass_to_c65.py files/extracted/{DISK}{FILE}.tas src/patchedgame/{DISK}/{FILE}.tas.s src/include/{FILE}.tas.i`
   This converts the source from TASS format into CC65 format.
7. Copy those files to `{FILE}.s` and `{FILE}.i`, or diff them with existing versions of those files. The reason I don't specify these files directly as script outputs for `tass_to_c65.py` is because there are always some manual edits I end up needing to make. Generating to separate files and diffing allows me to make further adjustments inside Regenerator without losing my manual edits. Alternatively, if you have a good `git difftool`, you could generate them directly and use git history to preserve post-Regenerator edits.


Planned Future Work
-------------------
This project was inspired by the C64 Remaster done by MagerValp. Some of those enhancements have not yet made it to Apple II, but I'd like to get it all here eventually.
* Try to fit entire game on one disk
* Replace "new game" slide show with artwork by Mermaid

Other personal goals include:
* Run on 128K machines with less disk access
* Run within a ProDOS folder

Credits and License
-------------------
[MagerValp/u4remastered](https://github.com/MagerValp/u4remastered) for Commodore 64 was the starting point for much of the symbolication and the project layout.

Additional work by Sean Gugler, including portions taken from his C64 fork of [u4remastered](https://github.com/sean-gugler/u4remastered), is &copy; 2021 and licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)
<img src="https://mirrors.creativecommons.org/presskit/icons/cc.svg" width="20px"><img src="https://mirrors.creativecommons.org/presskit/icons/by.svg" width="20px"><img src="https://mirrors.creativecommons.org/presskit/icons/sa.svg" width="20px">

The original Ultima IV game is &copy; 1985 Origin Systems, Inc.

This project is made in the interest of preservation and education with the generous consent of Richard Garriott, original author and creator of the Ultima series of games including Ultima IV.