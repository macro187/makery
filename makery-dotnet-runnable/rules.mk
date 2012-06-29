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
RULE_REQS := $(DOTNET_COPYLIBS_dotfile)
RULE_REQS += $(DOTNET_outfiles)
RULE_OREQ := $(DOTNET_RUNNABLE_outdir)

define RULE_COMMANDS
	-rm -rf $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir))/*

	-cp -r $(call SYSTEM_ShellEscape,$(DOTNET_COPYLIBS_outdir))/* $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir))/

	$(foreach d,$(DOTNET_BIN_subdirs),$(MAKE_CHAR_NEWLINE)	mkdir -p $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir))/$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(d))))

	$(foreach f,$(DOTNET_BIN_all),$(MAKE_CHAR_NEWLINE)	cp $(call SYSTEM_ShellEscape,$(DOTNET_BIN_dir)/$(call MAKE_DecodeWord,$(f))) $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_outdir)/$(call MAKE_DecodeWord,$(f))))

	touch $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_dotfile))
endef

$(call PROJ_Rule)


