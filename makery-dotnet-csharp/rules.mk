# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012
# Ron MacNeil <macro@hotmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# ------------------------------------------------------------------------------

RULE_TARGET := $(DOTNET_outfiles_main)
RULE_REQDBY := $(DOTNET_CS_out_debug)
RULE_REQS := $(SRCS_files_preq)
RULE_REQS += $(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs)
RULE_REQS += $(DOTNET_resources)
RULE_OREQS := $(call MAKE_EncodeWord,$(DOTNET_outdir))


ifeq ($(DOTNET_implementation),mono)
define RULE_COMMANDS
	$(DOTNET_CS_compiler) $(MAKE_CHAR_BS)
	$(DOTNET_CS_versionswitches) $(MAKE_CHAR_BS)
	-target:$(if $(filter lib,$(DOTNET_outtype)),library,$(if $(filter exe,$(DOTNET_outtype)),exe)) $(MAKE_CHAR_BS)
	-out:$(call SYSTEM_ShellEscape,$(DOTNET_outfiles_main)) $(MAKE_CHAR_BS)
	$(if $(filter debug,$(DOTNET_debug)),-debug) $(MAKE_CHAR_BS)
	$(if $(filter optimize,$(DOTNET_optimize)),-optimize+,-optimize-) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_checked)),-checked) $(MAKE_CHAR_BS)
	$(if $(DOTNET_CS_warn),-warn:$(DOTNET_CS_warn)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_werror)),-warnaserror) $(MAKE_CHAR_BS)
	$(foreach def,$(DOTNET_CS_defines),$(call PROJ_RuleNewLine,-define:$(def))) $(MAKE_CHAR_BS)
	-noconfig $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_nostdlib)),-nostdlib) $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNET_librefs),$$(call PROJ_RuleNewLine,-r:$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(lib))))) $(MAKE_CHAR_BS)
	$(foreach res,$(DOTNET_resources),$(call PROJ_RuleNewLine,-resource:$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(res))))) $(MAKE_CHAR_BS)
	$$(foreach src,$$(SRCS_files),$$(call PROJ_RuleNewLine,$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(src)))))
endef
endif


ifeq ($(DOTNET_implementation),ms)
define RULE_COMMANDS
	$(call SYSTEM_ShellEscape,$(DOTNET_CS_compiler)) $(MAKE_CHAR_BS)
	$(DOTNET_CS_versionswitches) $(MAKE_CHAR_BS)
	-nologo $(MAKE_CHAR_BS)
	-target:$(if $(filter lib,$(DOTNET_outtype)),library,$(if $(filter exe,$(DOTNET_outtype)),exe)) $(MAKE_CHAR_BS)
	-out:$(call SYSTEM_ShellEscape,$(call SYSTEM_WinPathAbs,$(DOTNET_outfiles_main))) $(MAKE_CHAR_BS)
	$(if $(filter debug,$(DOTNET_debug)),-debug) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_checked)),-checked) $(MAKE_CHAR_BS)
	$(if $(DOTNET_CS_warn),-warn:$(DOTNET_CS_warn)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_werror)),-warnaserror) $(MAKE_CHAR_BS)
	$(foreach define,$(DOTNET_CS_defines),$(call PROJ_RuleNewLine,-define:$(define))) $(MAKE_CHAR_BS)
	-noconfig $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_nostdlib)),-nostdlib) $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNET_librefs),$$(call PROJ_RuleNewLine,-r:$$(call SYSTEM_ShellEscape,$$(call SYSTEM_WinPathAbs,$$(call MAKE_DecodeWord,$$(lib)))))) $(MAKE_CHAR_BS)
	$(foreach res,$(DOTNET_resources),$(call PROJ_RuleNewLine,-resource:$(call SYSTEM_ShellEscape,$(call SYSTEM_WinPathAbs,$(call MAKE_DecodeWord,$(res)))))) $(MAKE_CHAR_BS)
	$$(foreach src,$$(SRCS_files),$$(call SYSTEM_ShellEscape,$$(call SYSTEM_WinPathAbs,$$(call MAKE_DecodeWord,$$(src)))))
endef
endif


ifeq ($(DOTNET_implementation),pnet)
define RULE_COMMANDS
	$(DOTNET_CS_compiler) \
	$(DOTNET_CS_versionswitches) \
	$(if $(filter lib,$(DOTNET_outtype)),-shared) \
	-o $(call SYSTEM_ShellEscape,$(DOTNET_out_main)) \
	$(if $(filter debug,$(DOTNET_debug)),-g) \
	$(if $(filter 1,$(DOTNET_CS_checked)),-fchecked) \
	$(if $(DOTNET_CS_warn),$(if $(filter 0,$(DOTNET_CS_warn)),,-Wall)) \
	$(if $(filter 1,$(DOTNET_CS_werror)),-Werror) \
	$(foreach define,$(DOTNET_CS_defines),$(call PROJ_RuleNewLine,-D$(define))) \
	$(if $(filter 1,$(DOTNET_CS_nostdlib)),-nostdlib) $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNET_librefs),$$(call PROJ_RuleNewLine,-l$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(lib))))) \
	$(foreach res,$(DOTNET_resources),$(call PROJ_RuleNewLine,-fresources=$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(res))))) \
	$$(call MAKE_CallForEach,SYSTEM_ShellEscape,$$(SRCS_files))
endef
endif

$(call PROJ_Rule)

