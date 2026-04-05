OUT := build
CONFIG ?= us
.SECONDARY:
MD5SUM := $(shell which md5 md5sum | head -n 1)
SHELL := $(shell which bash)

all: $(OUT)/superbomberman.sfc compare
.PHONY: all compare clean

-include $(OUT)/superbomberman.dep
# Files not caught by create_dep:
$(OUT)/superbomberman.sfc: config/$(CONFIG).asm $(OUT)/graphics/overlays/bomb_and_explosions_palette_0.bin $(OUT)/graphics/overlays/bomb_and_explosions_palette_1.bin

TITLE = "\033[1m\033[36m"
TITLE_END = "\033[0m"

$(OUT)/%.dep: %.asm
	mkdir -p $(OUT)
	python tools/create_dep.py $< "$(OUT)" > $@

$(OUT)/superbomberman.sfc: superbomberman.asm superbomberman.layout
	@echo -e $(TITLE)Compiling $@...$(TITLE_END)
	sfcasm $< -o $@ -l superbomberman.layout -V "CONFIG=\"$(CONFIG)\"" -DOUT="$(OUT)" -v "$(OUT)/superbomberman.var"  -s "$(OUT)/superbomberman.sym" -c


#### Graphic rules ####

CONVERTING_GRAPHIC = @echo -e $(TITLE)Converting graphic $<...$(TITLE_END)
EXTRACTING_PALETTES = @echo -e $(TITLE)Extracting palettes from $<...$(TITLE_END)

# Sprites
$(OUT)/graphics/sprites/%_graphic.bin $(shell echo build/graphics/sprites/%_graphic_{0..8}.bin): graphics/sprites/%.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py $< 

# Japanese sprites
$(OUT)/graphics/sprites/%_graphic_j.bin $(shell echo build/graphics/sprites/%_graphic_{0..8}_j.bin): graphics/sprites/%_j.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py $<

# Backgrounds
$(OUT)/graphics/backgrounds/%_graphic.bin: graphics/backgrounds/%.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py bg $<

# Japanese backgrounds
$(OUT)/graphics/backgrounds/%_graphic_j.bin: graphics/backgrounds/%_j.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py bg $<

# Overlays
$(OUT)/graphics/overlays/%_graphic.bin: graphics/overlays/%.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py overlay $<

# Specific files
$(OUT)/graphics/animated_tiles_graphic.bin: graphics/animated_tiles.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py raw $<

$(OUT)/graphics/bg3_tileset_graphic.bin: graphics/bg3_tileset.png
	@mkdir -p $(dir $@)
	$(CONVERTING_GRAPHIC)
	OUT=$(OUT) python tools/png_to_bin.py raw2 $<

# Multi-color graphics aliases.
$(OUT)/graphics/sprites/victory_pose_graphic_%.bin: $(OUT)/graphics/sprites/shiro_victory_pose_graphic_%.bin
	@mkdir -p $(dir $@)
	ln -sf $(realpath $<) $@
	
$(OUT)/graphics/sprites/mecha_bomberman_graphic_%.bin: $(OUT)/graphics/sprites/white_mecha_bomberman_graphic_%.bin
	@mkdir -p $(dir $@)
	ln -sf $(realpath $<) $@

# Palettes
$(OUT)/%_palette.bin $(shell echo $(OUT)/%_palette_{0..8}.bin): %.png
	@mkdir -p $(dir $@)
	$(EXTRACTING_PALETTES)
	OUT=$(OUT) python tools/extract_palettes.py $<

# Japanese sprites
$(OUT)/%_palette_j.bin $(shell echo $(OUT)/%_palette_{0..8}_j.bin) : %_j.png
	@mkdir -p $(dir $@)
	$(EXTRACTING_PALETTES)
	OUT=$(OUT) python tools/extract_palettes.py $<


#### DBoot (Sound engine) rules ####

# DBoot (Sound engine) configuration
MAX_SONG = 41

# Join all data together
$(OUT)/dboot/data.bin: dboot/banks.bin dboot/instruments.bin $(OUT)/dboot/samples.bin dboot/firmware.bin dboot/sound_effects.bin $(OUT)/dboot/songs.bin
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Joining DBoot data...$(TITLE_END)
	python tools/dboot.py join $@ $^

# dboot/firmware.bin:
#	Due to the lack of a decent SPC-700 disassembler, the DBoot firmware is only
#	partially disassembled and provided in binary form.

# %.brr: %.wav
#	I could not write a compression  algorithm that converts WAV files back to BRR
#   in a way that they are binary identical. (I.e. no data is lost in conversion).
#	Feel free to contribute one. :)

$(OUT)/dboot/samples.bin: dboot/samples.def $(shell ls dboot/samples/*.brr)
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Packing samples...$(TITLE_END)
	python tools/dboot.py pack-samples $< $@

$(OUT)/dboot/songs.bin: $(addprefix $(OUT)/,$(shell echo dboot/songs/song_{0..$(MAX_SONG)}.bin))
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Joining songs...$(TITLE_END)
	python tools/dboot.py join-songs $@ $^

# Duplicated songs
$(shell echo $(OUT)/dboot/songs/song_{30,32,34,36,38,40}.bin): $(OUT)/dboot/songs/song_13.bin
	@mkdir -p $(dir $@)
	ln -sf $(realpath $<) $@
	
$(shell echo $(OUT)/dboot/songs/song_{31,33,35,37,39,41}.bin): $(OUT)/dboot/songs/song_14.bin
	@mkdir -p $(dir $@)
	ln -sf $(realpath $<) $@
	
$(shell echo $(OUT)/dboot/songs/song_{24,25,26}.bin): $(OUT)/dboot/songs/song_23.bin
	@mkdir -p $(dir $@)
	ln -sf $(realpath $<) $@
	
$(shell echo $(OUT)/dboot/songs/song_{28,29}.bin): $(OUT)/dboot/songs/song_27.bin
	@mkdir -p $(dir $@)
	ln -sf $(realpath $<) $@

# Create songs from channels
define song_rule
$(OUT)/$(song).bin: $(addprefix $(OUT)/,$(shell find $(song) -name "*.py" | sort | sed s/\\.py/.bin/))
endef

$(foreach song,$(shell find dboot/songs -type d -name "song_*"), $(eval $(song_rule)))

$(OUT)/dboot/songs/song_%.bin: dboot/songs/song_%
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Combining song $@...$(TITLE_END)
	python tools/dboot.py join-channels $@ $(filter %.bin, $^)

$(OUT)/dboot/songs/%.bin: dboot/songs/%.py tools/compile_dboot_channel.py
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Compiling song channel $@...$(TITLE_END)
	python tools/compile_dboot_channel.py $< $@


#### Misc data ####

# Level structures (Tilemaps and Collision Data)
$(OUT)/level_structures/%.bin: level_structures/%.def
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Encoding $@...$(TITLE_END)
	python tools/level_structure.py encode $< $@

# Tilemaps
$(OUT)/tilemaps/%.bin: tilemaps/%.def
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Encoding $@...$(TITLE_END)
	python tools/tilemap.py encode $< $@

$(OUT)/tilemaps/compressed_%.bin: tilemaps/%.def
	@mkdir -p $(dir $@)
	@echo -e $(TITLE)Encoding $@...$(TITLE_END)
	python tools/tilemap.py compress $< $@


clean:
	-@rm -rf $(OUT)

compare: $(OUT)/superbomberman.sfc
	$(eval MD5 := $(shell $(MD5SUM) $< | sed "s/.*\([0-9a-f]\{32\}\).*/\\1/"))
	@echo -e "\033[1msuperbomberman.sfc               :" $(MD5) "\033[0m"
	@echo "Super Bomberman 1 (US)           : d83699a009a62480a7e7e9f1bb5bff6e" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E
	@echo "Super Bomberman 1 (J)            : cbef5f02304a2b821a0e1642a6307564" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E
	@echo "Super Bomberman 1 (E)            : ddee4ddff2f3b6e31b8f73d0cb597ef1" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E
	@echo "Super Bomberman 1 (US Prototype) : d67a1a2b0fac0564d950f8cd45fee3c2" | GREP_COLOR=32 grep ".+$(MD5)|^" --color -E


