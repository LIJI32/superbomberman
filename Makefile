#### General and ASM rules ####

OUT :=
CONFIG ?= us
.SECONDARY:
MD5SUM := $(shell which md5 md5sum | head -n 1)
SHELL := $(shell which bash)

# Update configuration selection file if needed
CONFIG_LINE := '.DEFINE CONFIG "$(CONFIG)"'

$(if $(shell ls config.asm 2>/dev/null), \
	$(if $(shell grep -v $(CONFIG_LINE) config.asm), \
		$(shell echo $(CONFIG_LINE) > config.asm) \
	), \
	$(shell echo $(CONFIG_LINE) > config.asm) \
)

all: rom.sfc compare
.PHONY: all compare clean

-include superbomberman.dep
# Files not caught by create_dep:
superbomberman.o: config/$(CONFIG).asm graphics/overlays/bomb_and_explosions_palette_0.bin graphics/overlays/bomb_and_explosions_palette_1.bin

TITLE = "\033[1m\033[36m"
TITLE_END = "\033[0m"

%.o: %.asm
	@echo -e $(TITLE)Compiling $@...$(TITLE_END)
	ca65 -g -t none --cpu 65816 $< -o $@

%.dep: %.asm
	@python tools/create_dep.py $< > $@

rom.sfc: superbomberman.o tools/checksum.py
	@echo -e $(TITLE)Creating $@...$(TITLE_END)
	ld65 $< -o $@ -C snes.cfg
	python tools/checksum.py $@


#### Graphic rules ####

CONVERTING_GRAPHIC = @echo -e $(TITLE)Converting graphic $<...$(TITLE_END)
EXTRACTING_PALETTES = @echo -e $(TITLE)Extracting palettes from $<...$(TITLE_END)

# Sprites
graphics/sprites/%_graphic.bin $(shell echo graphics/sprites/%_graphic_{0..8}.bin): graphics/sprites/%.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py $<

# Japanese sprites
graphics/sprites/%_graphic_j.bin $(shell echo graphics/sprites/%_graphic_{0..8}_j.bin): graphics/sprites/%_j.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py $<

# Backgrounds
graphics/backgrounds/%_graphic.bin: graphics/backgrounds/%.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py bg $<

# Japanese backgrounds
graphics/backgrounds/%_graphic_j.bin: graphics/backgrounds/%_j.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py bg $<

# Overlays
graphics/overlays/%_graphic.bin: graphics/overlays/%.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py overlay $<

# Specific files
graphics/animated_tiles_graphic.bin: graphics/animated_tiles.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py raw $<
graphics/bg3_tileset_graphic.bin: graphics/bg3_tileset.png
	$(CONVERTING_GRAPHIC)
	python tools/png_to_bin.py raw2 $<

# Multi-color graphics aliases.
graphics/sprites/victory_pose_graphic_%.bin: graphics/sprites/shiro_victory_pose_graphic_%.bin
	ln -sf $(realpath $<) $@
graphics/sprites/mecha_bomberman_graphic_%.bin: graphics/sprites/white_mecha_bomberman_graphic_%.bin
	ln -sf $(realpath $<) $@

# Palettes
%_palette.bin $(shell echo %_palette_{0..8}.bin): %.png
	$(EXTRACTING_PALETTES)
	python tools/extract_palettes.py $<

# Japanese sprites
%_palette_j.bin $(shell echo %_palette_{0..8}_j.bin) : %_j.png
	$(EXTRACTING_PALETTES)
	python tools/extract_palettes.py $<


#### DBoot (Sound engine) rules ####

# DBoot (Sound engine) configuration
MAX_SONG = 41

# Join all data together
dboot/data.bin: dboot/banks.bin dboot/instruments.bin dboot/samples.bin dboot/firmware.bin dboot/sound_effects.bin dboot/songs.bin
	@echo -e $(TITLE)Joining DBoot data...$(TITLE_END)
	python tools/dboot.py join $@ $^
TARGETS += dboot/data.bin

# dboot/firmware.bin:
#	Due to the lack of a decent SPC-700 disassembler, the DBoot firmware is only
#	partially disassembled and provided in binary form.

# %.brr: %.wav
#	I could not write a compression  algorithm that converts WAV files back to BRR
#   in a way that they are binary identical. (I.e. no data is lost in conversion).
#	Feel free to contribute one. :)

dboot/samples.bin: dboot/samples.def $(shell ls dboot/samples/*.brr)
	@echo -e $(TITLE)Packing samples...$(TITLE_END)
	python tools/dboot.py pack-samples $< $@
TARGETS += dboot/samples.bin

dboot/songs.bin: $(shell echo dboot/songs/song_{0..$(MAX_SONG)}.bin)
	@echo -e $(TITLE)Joining songs...$(TITLE_END)
	python tools/dboot.py join-songs $@ $^
TARGETS += dboot/songs.bin

# Duplicated songs
$(shell echo dboot/songs/song_{30,32,34,36,38,40}.bin): dboot/songs/song_13.bin
	ln -sf $(realpath $<) $@
$(shell echo dboot/songs/song_{31,33,35,37,39,41}.bin): dboot/songs/song_14.bin
	ln -sf $(realpath $<) $@
$(shell echo dboot/songs/song_{24,25,26}.bin): dboot/songs/song_23.bin
	ln -sf $(realpath $<) $@
$(shell echo dboot/songs/song_{28,29}.bin): dboot/songs/song_27.bin
	ln -sf $(realpath $<) $@

# Create songs from channels
define song_rule
$(song).bin: $(shell find $(song) -name "*.py" | sort | sed s/\\.py/.bin/)
TARGETS += $(song).bin
endef

$(foreach song,$(shell find dboot/songs -type d -name "song_*"), $(eval $(song_rule)))

dboot/songs/song_%.bin: dboot/songs/song_%
	@echo -e $(TITLE)Combining song $@...$(TITLE_END)
	python tools/dboot.py join-channels $@ $(filter %.bin, $^)

channel_%.bin: channel_%.py tools/compile_dboot_channel.py
	@echo -e $(TITLE)Compiling song channel $@...$(TITLE_END)
	python tools/compile_dboot_channel.py $< $@


#### Misc data ####

# Level structures (Tilemaps and Collision Data)
level_structures/%.bin: level_structures/%.def
	@echo -e $(TITLE)Encoding $@...$(TITLE_END)
	python tools/level_structure.py encode $< $@

# Tilemaps
tilemaps/%.bin: tilemaps/%.def
	@echo -e $(TITLE)Encoding $@...$(TITLE_END)
	python tools/tilemap.py encode $< $@

tilemaps/compressed_%.bin: tilemaps/%.def
	@echo -e $(TITLE)Encoding $@...$(TITLE_END)
	python tools/tilemap.py compress $< $@


clean:
	-@rm -f *.o *.dep rom.sfc $(TARGETS)
	-@find graphics -name "*.bin" -exec rm -rf {} \;
	-@find level_structures -name "*.bin" -exec rm -rf {} \;
	-@find tilemaps -name "*.bin" -exec rm -rf {} \;
	-@find dboot/songs -name "*.bin" -exec rm -rf {} \;
	-@find . -lname "*" -exec rm -rf {} \;

compare: rom.sfc
	$(eval MD5 := $(shell $(MD5SUM) $< | sed "s/.*\([0-9a-f]\{32\}\).*/\\1/"))
	@echo -e "\033[1mrom.sfc               :" $(MD5) "\033[0m"
	@echo "Super Bomberman 1 (US)           : d83699a009a62480a7e7e9f1bb5bff6e" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E
	@echo "Super Bomberman 1 (J)            : cbef5f02304a2b821a0e1642a6307564" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E
	@echo "Super Bomberman 1 (E)            : ddee4ddff2f3b6e31b8f73d0cb597ef1" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E
	@echo "Super Bomberman 1 (US Prototype) : d67a1a2b0fac0564d950f8cd45fee3c2" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E


