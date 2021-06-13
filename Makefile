SHELL = /bin/sh

# Configuration options

# Select source directory for game save files.
SAVEGAME=untouched
# SAVEGAME=maxed_surface

# Tweak to trade off compressed size for compression speed.
# Smallest size (largest offset) is 65535.
EXOMIZER_MAX_OFFSET=65535

#----------

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

# u4program.do etc.  ("do" = Dos Order sectors, disk image file)
DISKS = $(patsubst %,u4%.do,$(DISK_NAMES))

all: $(DISKS)


# Tools.

EXOMIZER=~/bin/exomizer

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
	$(patsubst %,$(patched_dir)/%,$(DISK_NAMES))

$(FOLDERS):
	mkdir -p $@


# Extract files from disk images.

ORIGINAL_DISKS = $(patsubst %,files/original/%,$(DISKS))

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
%.prg: %.o src/loadaddr.o $$(or $$(wildcard $$(@D)/$$*.cfg),src/patchedgame/overlay8800.cfg)
	$(LD65) -m $*.map -C $(filter %.cfg,$^) -Ln $*.lab \
		-o $@ $(LD65FLAGS) $(filter %.o,$^) || (rm -f $@ && exit 1)

game_dirs = $(patsubst %,src/patchedgame/%,$(DISK_NAMES))
game_files = $(foreach dir,$(game_dirs),$(dir)/*.o $(dir)/*.prg $(dir)/*.map $(dir)/*.lab)

CLEAN += clean_patchedgame
clean_patchedgame:
	rm -f $(game_files)


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


# Create disk images.

u4%.do : $$(PRG_FILES_%) $$(BIN_%)
	@echo "Creating $@"
	tools/dos33.py --format $@  || (rm -f $@ && exit 1)
	tools/dos33.py --sector-write --track 0 --sector 0 $@ $(BIN_$*)  || (rm -f $@ && exit 1)
	tools/dos33.py --write --attr $(extract_dir)/$*.attr $@ $(PRG_FILES_$*)  || (rm -f $@ && exit 1)

CLEAN += clean_diskimages
clean_diskimages:
	rm -f $(DISKS)


# Targets that are not explicit files

.PHONY: \
	all \
	extract \
	clean $(CLEAN) \
	distclean $(DISTCLEAN)

extract: $(EXTRACTED_DOS_FILES)

clean: $(CLEAN)

distclean: $(DISTCLEAN)
