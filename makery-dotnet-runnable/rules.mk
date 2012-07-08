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


RULE_TARGET := $(DOTNET_RUNNABLE_dotfile)
RULE_REQS = $(DOTNET_ASSEMBLY_all_abs)
RULE_REQS += $(call PROJ_GetMultiRecursive,DOTNET_ASSEMBLY_all_abs,DOTNET_projlibs)
RULE_OREQ := $(DOTNET_RUNNABLE_outdir)

define RULE_COMMANDS
	-rm -rf $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir))/*

	$(foreach d,$(sort $(DOTNET_ASSEMBLY_subdirs) $(call PROJ_GetMultiRecursive,DOTNET_ASSEMBLY_subdirs,DOTNET_projlibs)),$(MAKE_CHAR_NEWLINE)	mkdir -p $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir))/$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(d))))

	$(foreach n,$(sort $(PROJ_name) $(call PROJ_GetVarRecursive,PROJ_name,DOTNET_projlibs)),$(foreach f,$(call PROJ_GetVar,DOTNET_ASSEMBLY_all,$(n)),$(MAKE_CHAR_NEWLINE)	cp $(call SYSTEM_ShellEscape,$(call PROJ_GetVar,DOTNET_ASSEMBLY_dir,$(n))/$(call MAKE_DecodeWord,$(f))) $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir)/$(call MAKE_DecodeWord,$(f)))))

	touch $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_dotfile))
endef

$(call PROJ_Rule)


