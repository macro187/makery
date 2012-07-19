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


RULE_TARGET := $(DOTNETREFERENCES_dotfile)
RULE_REQS := $(call PROJ_GetMultiRecursive,DOTNETASSEMBLY_all_abs,DOTNETREFERENCES_proj)
RULE_REQS := $(DOTNETREFERENCES_reqs)
RULE_OREQ := $(DOTNETREFERENCES_outdir)

define RULE_COMMANDS
	-rm -rf $(call SYSTEM_ShellEscape,$(DOTNETREFERENCES_outdir))/*

	$(foreach d,$(call PROJ_GetMultiRecursive,DOTNETASSEMBLY_subdirs,DOTNETREFERENCES_proj),$(MAKE_CHAR_NEWLINE)	mkdir -p $(call SYSTEM_ShellEscape,$(DOTNETREFERENCES_outdir)/$(call MAKE_DecodeWord,$(d))))

	$(foreach n,$(call PROJ_GetVarRecursive,PROJ_name,DOTNETREFERENCES_proj),$(foreach f,$(call PROJ_GetVar,DOTNETASSEMBLY_all,$(n)),$(MAKE_CHAR_NEWLINE)	cp $(call SYSTEM_ShellEscape,$(call PROJ_GetVar,DOTNETASSEMBLY_dir,$(n))/$(call MAKE_DecodeWord,$(f))) $(call SYSTEM_ShellEscape,$(DOTNETREFERENCES_outdir)/$(call MAKE_DecodeWord,$(f)))))

	touch $(call SYSTEM_ShellEscape,$(DOTNETREFERENCES_dotfile))
endef

$(call PROJ_Rule)

