# ------------------------------------------------------------------------------
# Copyright (c) 2012
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


ifneq ($(filter pnet,$(DOTNETFRAMEWORK_implementation)),)


RULE_TARGET := $(DOTNETASSEMBLY_primary_abs)
RULE_REQDBY := $(CSHARP_debuginfo_abs)
RULE_REQS := $(SRCS_files_preq)
RULE_REQS += $(DOTNET_resources)
RULE_REQS += $(call PROJ_GetVarMulti,DOTNETASSEMBLY_primary_abs,$(DOTNETREFERENCES_proj))
RULE_OREQS := $(call MAKE_EncodeWord,$(DOTNET_outdir))


define RULE_COMMANDS
	$(CSHARP_compiler) $(MAKE_CHAR_BS)
	$(if $(filter lib,$(DOTNET_type)),-shared) $(MAKE_CHAR_BS)

	$(if $(filter 1,$(DOTNET_debug)),-g) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_optimize)),-O3) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(CSHARP_checked)),-fchecked) $(MAKE_CHAR_BS)
	$(if $(filter 1 2 3 4,$(CSHARP_warn)),-Wall) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(CSHARP_werror)),-Werror) $(MAKE_CHAR_BS)
	$(foreach d,$(CSHARP_defines), $(MAKE_CHAR_BS)$(MAKE_CHAR_NEWLINE)	-D$(d)) $(MAKE_CHAR_BS)
	$(foreach r,$(DOTNET_resources), $(MAKE_CHAR_BS)$(MAKE_CHAR_NEWLINE)	-fresources=$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(r)))) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNETREFERENCES_nostdlib)),-nostdlib) $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNETREFERENCES_gac_recursive), $$(MAKE_CHAR_BS)$$(MAKE_CHAR_NEWLINE)-l$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(lib)))) $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNETREFERENCES_proj_primary_recursive), $$(MAKE_CHAR_BS)$$(MAKE_CHAR_NEWLINE)-l$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(lib)))) $(MAKE_CHAR_BS)
	-o $(call SYSTEM_ShellEscape,$(DOTNETASSEMBLY_primary_abs)) $(MAKE_CHAR_BS)
	$$(foreach src,$$(SRCS_files), $$(MAKE_CHAR_BS)$$(MAKE_CHAR_NEWLINE)$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(src))))
endef


$(call PROJ_Rule)


endif


