# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009
# Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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


RULE_TARGETS := $(call MAKE_EncodeWord,$(DOTNET_outfiles_main))
RULE_TARGETS += $(call MAKE_EncodeWord,$(DOTNET_CS_out_debug))
RULE_REQS := $(SRCS_files_preq)
RULE_REQS += $(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs_abs)
RULE_REQS += $(DOTNET_resources)
RULE_OREQS := $(call MAKE_EncodeWord,$(DOTNET_outdir))


ifeq ($(DOTNET_implementation),mono)
define RULE_COMMANDS
	$(DOTNET_CS_compiler) $(MAKE_CHAR_BS)
	-target:$(if $(filter lib,$(DOTNET_outtype)),library,$(if $(filter exe,$(DOTNET_outtype)),exe)) $(MAKE_CHAR_BS)
	-out:$(call SHELL_Escape,$(DOTNET_outfiles_main)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_debug)),-debug) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_checked)),-checked) $(MAKE_CHAR_BS)
	$(if $(DOTNET_CS_warn),-warn:$(DOTNET_CS_warn)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_werror)),-warnaserror) $(MAKE_CHAR_BS)
	$(foreach def,$(DOTNET_CS_defines),$(call PROJ_RuleNewLine,-define:$(def))) $(MAKE_CHAR_BS)
	$(foreach lib,$(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs_abs),$(call PROJ_RuleNewLine,-r:$(call SHELL_Escape,$(call MAKE_DecodeWord,$(lib))))) $(MAKE_CHAR_BS)
	$(foreach lib,$(DOTNET_libs) $(call PROJ_GetMultiRecursive,DOTNET_libs,DOTNET_projlibs_abs),$(call PROJ_RuleNewLine,-r:$(call SHELL_Escape,$(call MAKE_DecodeWord,$(lib))))) $(MAKE_CHAR_BS)
	$(foreach res,$(DOTNET_resources),$(call PROJ_RuleNewLine,-resource:$(call SHELL_Escape,$(call MAKE_DecodeWord,$(res))))) $(MAKE_CHAR_BS)
	$$(foreach src,$$(SRCS_files),$$(call PROJ_RuleNewLine,$$(call SHELL_Escape,$$(call MAKE_DecodeWord,$$(src)))))
endef
endif


ifeq ($(DOTNET_implementation),ms)
define RULE_COMMANDS
	$(call SHELL_Escape,$(call OS_WinPath,$(DOTNET_CS_compiler))) $(MAKE_CHAR_BS)
	/nologo $(MAKE_CHAR_BS)
	/target:$(if $(filter lib,$(DOTNET_outtype)),library,$(if $(filter exe,$(DOTNET_outtype)),exe)) $(MAKE_CHAR_BS)
	/out:$(call SHELL_Escape,$(call OS_WinPath,$(DOTNET_outfiles_main))) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_debug)),/debug) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_checked)),/checked) $(MAKE_CHAR_BS)
	$(if $(DOTNET_CS_warn),/warn:$(DOTNET_CS_warn)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_CS_werror)),/warnaserror) $(MAKE_CHAR_BS)
	$(foreach define,$(DOTNET_CS_defines),$(call PROJ_RuleNewLine,/define:$(define))) $(MAKE_CHAR_BS)
	$(foreach lib,$(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs_abs),$(call PROJ_RuleNewLine,/r:$(call SHELL_Escape,$(call OS_WinPath,$(call MAKE_DecodeWord,$(lib)))))) $(MAKE_CHAR_BS)
	$(foreach lib,$(DOTNET_libs) $(call PROJ_GetMultiRecursive,DOTNET_libs,DOTNET_projlibs_abs),$(call PROJ_RuleNewLine,/r:$(call SHELL_Escape,$(call OS_WinPath,$(call MAKE_DecodeWord,$(lib)))))) $(MAKE_CHAR_BS)
	$(foreach res,$(DOTNET_resources),$(call PROJ_RuleNewLine,/resource:$(call SHELL_Escape,$(call OS_WinPath,$(call MAKE_DecodeWord,$(res)))))) $(MAKE_CHAR_BS)
	$$(foreach src,$$(SRCS_files),$$(call SHELL_Escape,$$(call OS_WinPath,$$(call MAKE_DecodeWord,$$(src)))))
endef
endif


ifeq ($(DOTNET_implementation),pnet)
define RULE_COMMANDS
	$(DOTNET_CS_compiler) \
	$(if $(filter lib,$(DOTNET_outtype)),-shared) \
	-o $(call SHELL_Escape,$(DOTNET_out_main)) \
	$(if $(filter 1,$(DOTNET_CS_debug)),-g) \
	$(if $(filter 1,$(DOTNET_CS_checked)),-fchecked) \
	$(if $(DOTNET_CS_warn),$(if $(filter 0,$(DOTNET_CS_warn)),,-Wall)) \
	$(if $(filter 1,$(DOTNET_CS_werror)),-Werror) \
	$(foreach define,$(DOTNET_CS_defines),$(call PROJ_RuleNewLine,-D$(define))) \
	$(foreach lib,$(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs_abs),$(call PROJ_RuleNewLine,-l$(call SHELL_Escape,$(call MAKE_DecodeWord,$(lib))))) \
	$(foreach lib,$(DOTNET_libs) $(call PROJ_GetMultiRecursive,DOTNET_libs,DOTNET_projlibs_abs),$(call PROJ_RuleNewLine,-l$(call SHELL_Escape,$(call MAKE_DecodeWord,$(lib))))) \
	$(foreach res,$(DOTNET_resources),$(call PROJ_RuleNewLine,-fresources=$(call SHELL_Escape,$(call MAKE_DecodeWord,$(res))))) \
	$$(call MAKE_CallForEach,SHELL_Escape,$$(SRCS_files))
endef
endif


$(call PROJ_Rule)

