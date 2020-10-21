ifeq ($(GAME),)
$(error GAME needs to be defined, e.g. 'GAME=npea00385 make')
endif

ifeq ($(MOD),)
$(error MOD needs to be defined, e.g. 'MOD=multi make')
endif

ROOT := $(GAME)/mods/$(MOD)
INCLUDE := -I$(GAME)/ -Isystem/

CC := clang
CFLAGS := -fno-builtin -nostdlib -nodefaultlibs -mcmodel=small -target powerpc-unknown-lv2 -S -O3 $(INCLUDE)

AS := clang
SFLAGS := -target powerpc64-unknown-none -c

LD := ./ld.lld
LFLAGS := -melf64ppc -T$(GAME)/linker.ld

BIN_PATH := $(ROOT)/bin
SRC_PATH := $(ROOT)/src
OBJ_PATH := $(ROOT)/obj

TARGET_NAME := $(MOD).elf
TARGET := $(BIN_PATH)/$(TARGET_NAME)

SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c)))
ASM := $(addprefix $(OBJ_PATH)/, $(addsuffix .s, $(notdir $(basename $(SRC)))))
OBJ := $(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

CLEAN_LIST := $(TARGET) $(ASM) $(OBJ)

default: all

$(TARGET): $(OBJ)
	@mkdir -p $(@D)
	$(LD) $(LFLAGS) -o $@ $?

$(OBJ_PATH)/%.o: $(OBJ_PATH)/%.s
	$(AS) $(SFLAGS) -o $@ $<

$(OBJ_PATH)/%.s: $(SRC_PATH)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $<

.PHONY: all
all: $(TARGET)

.PHONY: clean
clean:
	@rm -f $(CLEAN_LIST)
