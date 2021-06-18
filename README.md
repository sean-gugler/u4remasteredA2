Ultima IV for Apple II, Remastered
==================================

https://github.com/sean-gugler/u4remasteredA2

This source code has been reconstructed by disassembling and symbolicating the 1985 binary code released for Apple II series computers. It likely bears little resemblance to the original source, but it can be used by modern tools to build the same playable binaries.

This is a work in progress. The current state is functional, but some of the source is not yet fully documented or symbolicated.

Branches
---------

The branch "**fixed**" includes numerous bug fixes and spelling/grammar corrections, as well as some non-intrusive improvements upon the original game. New features are silent unless invoked, so players may choose to ignore them and experience the game as originally designed.

The branch "**documented**" can re-create binary code identical to the original. Some original bugs are noted in the source, but not fixed, in this branch. A curious visitor may diff the two branches to review exactly what was changed.


Building
--------

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

| **Tech Note:** These files match the byte streams as stored in DOS 3.3, including the "load address" value (byte offsets 0 and 1) but minus the "file length" value (byte offsets 2 and 3) which is instead implicit in the file size. This is so the resulting .prg files are natively parseable by Regenerator. |

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
* Add a trainer (cheat codes)
* Try to fit entire game on one disk
* Replace "new game" slide show with artwork by Mermaid

Other personal goals include:
* Finish symbolicating all disassembled source
* Generate a slideshow disk of game artwork sources
* Run on 128K machines with less disk access.

Credits and License
-------------------
[MagerValp/u4remastered](https://github.com/MagerValp/u4remastered) for Commodore 64 was the starting point for much of the symbolication and the project layout.
Additional work by Sean Gugler, including portions taken from his C64 fork of [u4remastered](https://github.com/sean-gugler/u4remastered), is &copy; 2021 and licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)
![](https://mirrors.creativecommons.org/presskit/icons/cc.svg)![](https://mirrors.creativecommons.org/presskit/icons/by.svg)![](https://mirrors.creativecommons.org/presskit/icons/sa.svg)
The original Ultima IV game is &copy; 1985 Origin Systems, Inc.
This project is made in the interest of preservation and education with the generous consent of Richard Garriott, original author and creator of the Ultima series of games including Ultima IV.