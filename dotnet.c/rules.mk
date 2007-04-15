# ------------------------------------------------------------------------------
# Copyright (c) 2007 Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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
#RULE_TARGETS += $(call MAKE_EncodeWord,$(DOTNET_C_out_debug))
RULE_REQS := $(SRCS_files_preq)
RULE_REQS += $(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs_abs)
RULE_REQS += $(DOTNET_resources)
RULE_OREQS := $(call MAKE_EncodeWord,$(DOTNET_outdir))

define RULE_COMMANDS
	cscc $(MAKE_CHAR_BS)
	$(if $(filter lib,$(DOTNET_outtype)),-shared) $(MAKE_CHAR_BS)
	-o $(call SHELL_Escape,$(DOTNET_outfiles_main)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_C_debug)),-g) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_C_checked)),-fchecked) $(MAKE_CHAR_BS)
	$(if $(DOTNET_C_warn),$(if $(filter 0,$(DOTNET_C_warn)),,-Wall)) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_C_werror)),-Werror) $(MAKE_CHAR_BS)
	$(foreach define,$(DOTNET_C_defines),\$(MAKE_CHAR_NEWLINE)	-D$(define)) $(MAKE_CHAR_BS)
	$(foreach lib,$(call PROJ_GetVarRecursive,DOTNET_outfiles_main,DOTNET_projlibs_abs),\$(MAKE_CHAR_NEWLINE)	-l$(call SHELL_Escape,$(call MAKE_DecodeWord,$(lib)))) $(MAKE_CHAR_BS)
	$(foreach lib,$(DOTNET_libs) $(call PROJ_GetMultiRecursive,DOTNET_libs,DOTNET_projlibs_abs),\$(MAKE_CHAR_NEWLINE)	-l$(call SHELL_Escape,$(call MAKE_DecodeWord,$(lib)))) $(MAKE_CHAR_BS)
	$(foreach res,$(DOTNET_resources),\$(MAKE_CHAR_NEWLINE)	-fresources=$(call SHELL_Escape,$(call MAKE_DecodeWord,$(res)))) $(MAKE_CHAR_BS)
	$$(call MAKE_CallForEach,SHELL_Escape,$$(SRCS_files))
endef

$(call PROJ_Rule)

