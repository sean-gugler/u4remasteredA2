# default target (first one listed). Actual dependencies added at bottom of file.
all:

#----------
# Configuration options

# Select source directory for game save files.
SAVEGAME=untouched
# SAVEGAME=maxed_surface

# Tweak to trade off compressed size for compression speed.
# Smallest size (largest offset) is 65535.
# EXOMIZER_MAX_OFFSET=65535

#----------

SHELL = /bin/sh

# Remove unfinished targets if interrupted or command failed
.DELETE_ON_ERROR:

# Allow $ expansion in prerequisites (dependencies)
.SECONDEXPANSION:

# Clear all implicit rules built-in to the "make" program
.SUFFIXES:

# Compiler settings for target platform.
TARGET=apple2
CC65=cl65
AS65=ca65
LD65=ld65
CC65FLAGS=-Oirs -t $(TARGET)
AS65FLAGS=-t $(TARGET) -I . -I src/include --debug-info
LD65FLAGS=

%.o: %.c
	$(CC65) -c $(CC65FLAGS) $<

%.o: %.s
	$(AS65) $(AS65FLAGS) $<


# Disks.
DISK_NAMES = program britannia towne underworld

output_dir = output

# u4program.do etc.  ("do" = Dos Order sectors, disk image file)
DISKS = $(patsubst %,$(output_dir)/u4%.do,$(DISK_NAMES))


# Tools.

# EXOMIZER=~/bin/exomizer

DISTCLEAN += clean_tools
clean_tools:
	rm -f tools/*.pyc

clean_tempfiles:
	find . -name '*.bak' -delete
	find . -name '*.orig' -delete
	find . -name '*.\~*' -delete


# Game files.
# Changing these requires a clean rebuild.

PROGRAM_FILES = \
	ANIM BGND BOOT CRDS DISK HTXT INIT MBSI MBSM \
	MUSB MUSC MUSD MUSO MUST NLST NPRT NRST SEL \
	SHP0 SHP1 SUBS TBLS ULT4 \
	FAIR.SPK  GYPS.SPK  LOOK.SPK  PRTL.SPK \
	TABL.SPK  TREE.SPK  WAGN.SPK\
	NEWGAME

BRITANNIA_FILES = \
	CAMP CONB CONC COND CONE CONF CONG \
	CONH CONI CONO CONP CONR CONS CONT \
	DISK HELP HOLE LIST LORD MIX \
	MUSB MUSO PRTY ROST SAVE SEAR \
	SHRI SHRN TLST TMAP USE

TOWNE_FILES = \
	CONA CONB CONC COND CONF CONG CONH CONO CONR CONS \
	DISK MAP@ \
	MAPA MAPB MAPC MAPD MAPE MAPF MAPG MAPH \
	MAPI MAPJ MAPK MAPL MAPM MAPN MAPO MAPP \
	MIX  MUSC MUST SEAR \
	SHP0 SHP1 SHP2 SHP3 SHP4 \
	SHP5 SHP6 SHP7 SHP8 SHP9 \
	SHPS TALK TMAP USE

UNDERWORLD_FILES = \
	CAMP CON0 CON1 CON2 CON3 CON4 CON5 CON6 DISK \
	DNG0 DNG1 DNG2 DNG3 DNG4 DNG5 DNG6 DNG7 DNGD \
	END  HOLE MIX  MUSB MUSD SEAR TMAP USE \
	CSTRING

EXTRACTED_SECTORS = \
	towne/TLK.bin \
	program/DOS.bin \
	britannia/MAP.bin \
	underworld/DNG.bin


# Save Game files - override whatever was stored on original disk

save_dir = files/savegame/$(SAVEGAME)

# Generated directories

extract_dir = files/extracted
patched_dir = files/patched

FOLDERS = \
	$(extract_dir) \
	$(output_dir) \
	$(patsubst %,$(patched_dir)/%,$(DISK_NAMES))

$(FOLDERS):
	mkdir -p $@


# Extract files from disk images.

ORIGINAL_DISKS = $(patsubst $(output_dir)/%,files/original/%,$(DISKS))

EXTRACTED_DOS_FILES = \
	$(patsubst %,$(extract_dir)/towne/%.prg,$(TOWNE_FILES)) \
	$(patsubst %,$(extract_dir)/program/%.prg,$(PROGRAM_FILES)) \
	$(patsubst %,$(extract_dir)/britannia/%.prg,$(BRITANNIA_FILES)) \
	$(patsubst %,$(extract_dir)/underworld/%.prg,$(UNDERWORLD_FILES)) \
	$(patsubst %,$(extract_dir)/%,$(EXTRACTED_SECTORS))

$(EXTRACTED_DOS_FILES) : tools/extract_files.py $(ORIGINAL_DISKS) | $(extract_dir)
	$^ $(extract_dir)

DISTCLEAN += clean_extracted
clean_extracted:
	rm -rf $(extract_dir)


# Talk data.

$(patched_dir)/towne/TLK.bin: tools/gen_talk.py src/talk/talk.json | $(patched_dir)/towne
	$^ $@


# Patched data files.

$(patched_dir)/%: tools/binpatch.py $(extract_dir)/% patches/%.patch | $$(@D)
	$^ $@


# Patched game files.

# prefer %.cfg if it exists, else use common overlay8800.cfg
%.prg: %.o src/loadaddr.o $$(or $$(wildcard $$(@D)/$$(*F).cfg),src/patchedgame/overlay8800.cfg)
	$(LD65) -m $*.map -C $(filter %.cfg,$^) -Ln $*.lab \
		-o $@ $(LD65FLAGS) $(filter %.o,$^) || (rm -f $@ && exit 1)

#   NOTE on Make compatibility above
#   Ideally we'd use this:      $$(wildcard $$*.cfg)
#   Gnu Make 4.3 expands $* within prerequisites as "path/file" which WORKS
#   Gnu Make 4.2 expands $* within prerequisites as "file" which FAILS
#   Both versions expand $* within recipe as "path/file" (so, fixed in 4.3)
#   Both versions work if we reconstruct full pathname with Directory from $@ plus File from $*

game_dirs = $(patsubst %,src/patchedgame/%,$(DISK_NAMES))
game_files = $(foreach dir,$(game_dirs),$(dir)/*.o $(dir)/*.prg $(dir)/*.map $(dir)/*.lab)

CLEAN += clean_patchedgame
clean_patchedgame:
	rm -f $(game_files)


# Dependencies

DEPS = $(patsubst %.s,%.d,$(wildcard src/*/*.s src/*/*/*.s))

include $(DEPS)

%.d: tools/make_dep.py %.s
	$^ $@


# Final game files.

# prefer, in order,
#    $build/prg if the corresponding .s exists
#    $patched/prg if the corresponding .patch exists
#    $save_dir/prg if a replacement exists
#    $original/prg
build = src/patchedgame/$(disk)
patched = $(patched_dir)/$(disk)
original = $(extract_dir)/$(disk)

PRG_FOLDER  = $(if $(wildcard $(build)/$(file).s),$(build),$(check_patch))
check_patch = $(if $(wildcard patches/$(disk)/$(file).prg.patch),$(patched),$(check_save))
check_save  = $(if $(wildcard $(save_dir)/$(file).prg),$(save_dir),$(original))

BIN_FILE = $(filter $(disk)%,$(EXTRACTED_SECTORS))
BIN_FOLDER = $(if $(wildcard patches/$(BIN_FILE).patch),$(patched_dir),$(extract_dir))

towne_FILES = $(TOWNE_FILES)
program_FILES = $(PROGRAM_FILES)
britannia_FILES = $(BRITANNIA_FILES)
underworld_FILES = $(UNDERWORLD_FILES)

disk = towne
PRG_FILES_$(disk) := $(foreach file, $($(disk)_FILES), $(PRG_FOLDER)/$(file).prg)
BIN_$(disk) := $(patched_dir)/$(BIN_FILE)

disk = program
PRG_FILES_$(disk) := $(foreach file, $($(disk)_FILES), $(PRG_FOLDER)/$(file).prg)
BIN_$(disk) := $(BIN_FOLDER)/$(BIN_FILE)

disk = britannia
PRG_FILES_$(disk) := $(foreach file, $($(disk)_FILES), $(PRG_FOLDER)/$(file).prg)
BIN_$(disk) := $(BIN_FOLDER)/$(BIN_FILE)

disk = underworld
PRG_FILES_$(disk) := $(foreach file, $($(disk)_FILES), $(PRG_FOLDER)/$(file).prg)
BIN_$(disk) := $(BIN_FOLDER)/$(BIN_FILE)


# Trainer.

src/trainer/TRAINERS.cfg: tools/cfg_symbols.py src/trainer/TRAINERS.cfg_segments src/patchedgame/program/ULT4.prg
	$(subst .prg,.lab,$^) $@

PRG_FILES_program := $(PRG_FILES_program) src/trainer/TRAINERS.prg src/trainer/MENU.prg


# Create disk images.

$(output_dir)/u4%.do: $$(PRG_FILES_%) $$(BIN_%)
	@echo "Creating $@"
	tools/dos33.py --format $@  || (rm -f $@ && exit 1)
	tools/dos33.py --sector-write --track 0 --sector 0 $@ $(BIN_$*)  || (rm -f $@ && exit 1)
	tools/dos33.py --write --attr $(extract_dir)/$*.attr $@ $(PRG_FILES_$*)  || (rm -f $@ && exit 1)

CLEAN += clean_diskimages
clean_diskimages:
	rm -f $(DISKS)


# Slideshow disks

program_dir = $(extract_dir)/program
slideshow_dir_1 = files/slideshows/start
slideshow_dir_2 = files/slideshows/end

INTRO_FILES = $(filter %.SPK,$(PROGRAM_FILES))

TILE_FILES = $(filter $(program_dir)/SHP%,$(PRG_FILES_program))
TILE_SLIDES = \
	$(slideshow_dir_1)/TILES00.prg \
	$(slideshow_dir_1)/TILES80.prg

SLIDE_FILES_1 = \
	HELLO.bas \
	ANIM.prg BGND.prg \
	$(patsubst %.SPK,%.prg,$(INTRO_FILES)) \
	CARDS0.prg CARDS1.prg \
	FONT.prg

$(slideshow_dir_1)/ANIM.prg: $(program_dir)/ANIM.prg
	cp $^ $@

$(slideshow_dir_1)/BGND.prg: $(program_dir)/BGND.prg
	cp $^ $@

$(slideshow_dir_1)/%.prg: tools/spk.py $(program_dir)/%.SPK.prg
	$^ $@

$(slideshow_dir_1)/CARDS%.prg: tools/cards.py $(program_dir)/CRDS.prg
	$^ $(slideshow_dir_1)

$(TILE_SLIDES): tools/tile_sheet.py $(TILE_FILES)
	$^ $(TILE_SLIDES)

$(slideshow_dir_1)/FONT.prg: tools/font.py $(program_dir)/HTXT.prg
	$^ $@

$(slideshow_dir_2)/END_WIN.prg: tools/end_screens.py $(extract_dir)/underworld/CSTRING.prg
	$^ $(slideshow_dir_2)

$(output_dir)/slideshow_start.do: $(patsubst %,$(slideshow_dir_1)/%,$(SLIDE_FILES_1)) $(TILE_SLIDES)
	@echo "Creating $@"
	tools/dos33.py --format $@  || (rm -f $@ && exit 1)
	tools/dos33.py --sector-write --track 0 --sector 0 $@ files/slideshows/DOS33.bin  || (rm -f $@ && exit 1)
	tools/dos33.py --write --attr files/slideshows/DOS33.attr $@ $^  || (rm -f $@ && exit 1)

$(output_dir)/slideshow_end.do: $(slideshow_dir_2)/END_WIN.prg
	@echo "Creating $@"
	tools/dos33.py --format $@  || (rm -f $@ && exit 1)
	tools/dos33.py --sector-write --track 0 --sector 0 $@ files/slideshows/DOS33.bin  || (rm -f $@ && exit 1)
	tools/dos33.py --write --attr files/slideshows/DOS33.attr $@ $(slideshow_dir_2)  || (rm -f $@ && exit 1)


CLEAN += clean_slideshow
clean_slideshow:
	rm -f $(slideshow_dir_1)/*.prg $(slideshow_dir_2)/.prg $(output_dir)/slideshow_start.do $(output_dir)/slideshow_end.do


# Mockingboard driver, split for analysis with Regenerator
# MBSM.prg => MBSMa.prg MBSMb.prg

mb_dir = $(extract_dir)/program
MB_FILES = $(mb_dir)/MBSMa.prg $(mb_dir)/MBSMb.prg

$(MB_FILES): tools/mbsm_split.py $(mb_dir)/MBSM.prg
	$^


# Targets that are not explicit files

.PHONY: \
	all \
	extract \
	clean $(CLEAN) \
	distclean $(DISTCLEAN)

extract: $(EXTRACTED_DOS_FILES)

clean: $(CLEAN)

distclean: $(DISTCLEAN)

all: $(DISKS) $(MB_FILES) $(output_dir)/slideshow_start.do $(output_dir)/slideshow_end.do | $(output_dir)
