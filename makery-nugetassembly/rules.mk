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


RULE_TARGET := $(NUGETASSEMBLY_dotfile)
RULE_REQS += $(call MAKE_EncodeWord,$(NUGET_dotfile))
RULE_OREQS += $(call MAKE_EncodeWord,$(NUGETASSEMBLY_outdir))
RULE_OREQS += $(call MAKE_EncodeWord,$(DOTNETASSEMBLY_outdir))
RULE_REQDBY := $(DOTNETASSEMBLY_dotfile)

define RULE_COMMANDS
	rm -rf $(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_outdir))/*
	
	cp $(call SYSTEM_ShellEscape,$(NUGET_outdir))/$(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_path))/$(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_primaryfile)) $(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_outdir))/
ifneq ($(NUGETASSEMBLY_extrafiles),)
	cp $(foreach f,$(NUGETASSEMBLY_extrafiles),$(call SYSTEM_ShellEscape,$(NUGET_outdir))/$(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_path))/$(call SYSTEM_ShellEscape,$(call MAKE_DecodeWord,$(f)))) $(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_outdir))/
endif
ifneq ($(NUGETASSEMBLY_useallfiles),)
	cp -rv $(call SYSTEM_ShellEscape,$(NUGET_outdir))/$(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_path))/* $(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_outdir))/
endif
	
	rm -rf $(call SYSTEM_ShellEscape,$(DOTNETASSEMBLY_outdir))/*
	cp -rv $(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_outdir))/* $(call SYSTEM_ShellEscape,$(DOTNETASSEMBLY_outdir))/
	
	touch $(call SYSTEM_ShellEscape,$(NUGETASSEMBLY_dotfile))
endef

$(call PROJ_Rule)

