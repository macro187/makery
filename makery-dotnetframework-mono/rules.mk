# ------------------------------------------------------------------------------
# Copyright (c) Ron MacNeil <macro@hotmail.com>
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


ifneq ($(filter mono,$(DOTNETFRAMEWORK_implementation)),)


RULE_TARGET := $(DOTNET_dotfile)
RULE_REQS += $(SRCS_preqs)
RULE_REQS += $(DOTNET_resources)
RULE_REQS += $(call MAKE_EncodeWord,$(DOTNETREFERENCES_dotfile))
RULE_OREQS += $(call MAKE_EncodeWord,$(DOTNET_outdir))
RULE_OREQS += $(call MAKE_EncodeWord,$(DOTNETASSEMBLY_outdir))
RULE_REQDBY := $(DOTNETASSEMBLY_dotfile)


define RULE_COMMANDS
	rm -rf $(call SYSTEM_ShellEscape,$(DOTNET_outdir))/*
	$(CSHARP_compiler) $(MAKE_CHAR_BS)
	-target:$(if $(filter exe,$(DOTNET_type)),exe,library) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_debug)),-debug+,-debug-) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNET_optimize)),-optimize+,-optimize-) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(CSHARP_checked)),-checked+,-checked-) $(MAKE_CHAR_BS)
	-warn:$(CSHARP_warn) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(CSHARP_werror)),-warnaserror+,-warnaserror-) $(MAKE_CHAR_BS)
	$(foreach d,$(CSHARP_defines), $(MAKE_CHAR_BS)$(MAKE_CHAR_NEWLINE)	-define:$(d)) $(MAKE_CHAR_BS)
	$(foreach r,$(DOTNET_resources), $(MAKE_CHAR_BS)$(MAKE_CHAR_NEWLINE)	-resource:$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(r)))) $(MAKE_CHAR_BS)
	$(if $(filter 1,$(DOTNETREFERENCES_nostdlib)),-nostdlib+,-nostdlib-) $(MAKE_CHAR_BS)
	-noconfig $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNETREFERENCES_gac_recursive), $$(MAKE_CHAR_BS)$$(MAKE_CHAR_NEWLINE)-r:$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(lib)))) $(MAKE_CHAR_BS)
	$$(foreach lib,$$(DOTNETREFERENCES_proj_primary_recursive), $$(MAKE_CHAR_BS)$$(MAKE_CHAR_NEWLINE)-r:$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(lib)))) $(MAKE_CHAR_BS)
	-out:$(call SYSTEM_ShellEscape,$(DOTNET_outdir)/$(DOTNET_filename)) $(MAKE_CHAR_BS)
	$$(foreach src,$$(SRCS_files), $$(MAKE_CHAR_BS)$$(MAKE_CHAR_NEWLINE)$$(call SYSTEM_ShellEscape,$$(call MAKE_DecodeWord,$$(src))))
	touch $(call SYSTEM_ShellEscape,$(DOTNET_dotfile))
	
	rm -rf $(call SYSTEM_ShellEscape,$(DOTNETASSEMBLY_outdir))/*
	cp -rv $(call SYSTEM_ShellEscape,$(DOTNET_outdir))/* $(call SYSTEM_ShellEscape,$(DOTNETASSEMBLY_outdir))/
endef


$(call PROJ_Rule)


endif


