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


RULE_TARGET := $(DOTNETEXE_dotfile)
RULE_REQS += $(call MAKE_EncodeWord,$(DOTNETASSEMBLY_dotfile))
RULE_REQS += $(call MAKE_EncodeWord,$(DOTNETREFERENCES_dotfile))
RULE_OREQ := $(DOTNETEXE_outdir)
RULE_REQDBY := $(RUNNABLE_dotfile)

define RULE_COMMANDS
	-rm -rf $(call SYSTEM_ShellEscape,$(DOTNETEXE_outdir))/*
	-cp -vr $(call SYSTEM_ShellEscape,$(DOTNETREFERENCES_outdir))/* $(call SYSTEM_ShellEscape,$(DOTNETEXE_outdir))/
	-cp -vr $(call SYSTEM_ShellEscape,$(DOTNETASSEMBLY_outdir))/* $(call SYSTEM_ShellEscape,$(DOTNETEXE_outdir))/
	touch $(call SYSTEM_ShellEscape,$(DOTNETEXE_dotfile))
endef

$(call PROJ_Rule)


