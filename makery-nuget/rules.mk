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


ifeq ($(NUGET_RULECREATED),)

RULE_TARGET := $(NUGET_SHARED)
RULE_OREQ := $(TEMPDIR_TEMPDIR)

#
# TODO Don't just assume curl is present
#
define RULE_COMMANDS
	test -f $(call SYSTEM_ShellEscape,$(NUGET_SHARED)) || curl -s -L -f $(call SYSTEM_ShellEscape,$(NUGET_URL)) > $(call SYSTEM_ShellEscape,$(TEMPDIR_TEMPDIR))/nuget.$(MAKE_PID).exe
	test -f $(call SYSTEM_ShellEscape,$(TEMPDIR_TEMPDIR))/nuget.$(MAKE_PID).exe && mv -f $(call SYSTEM_ShellEscape,$(TEMPDIR_TEMPDIR))/nuget.$(MAKE_PID).exe $(call SYSTEM_ShellEscape,$(NUGET_SHARED))
	find $(call SYSTEM_ShellEscape,$(NUGET_SHARED)) -mtime +1 && cp -f $(call SYSTEM_ShellEscape,$(NUGET_SHARED)) $(TEMPDIR_TEMPDIR)/nuget.$(MAKE_PID).exe
	-test -f $(call SYSTEM_ShellEscape,$(TEMPDIR_TEMPDIR))/nuget.$(MAKE_PID).exe && $(call DOTNETFRAMEWORK_Exec,$(TEMPDIR_TEMPDIR)/nuget.$(MAKE_PID).exe) update -self
	test -f $(call SYSTEM_ShellEscape,$(TEMPDIR_TEMPDIR))/nuget.$(MAKE_PID).exe && mv -f $(call SYSTEM_ShellEscape,$(TEMPDIR_TEMPDIR))/nuget.$(MAKE_PID).exe $(call SYSTEM_ShellEscape,$(NUGET_SHARED))
endef

$(call PROJ_Rule)

NUGET_RULECREATED := 1
endif


RULE_TARGET := $(NUGET_dotfile)
RULE_OREQS += $(call MAKE_EncodeWord,$(NUGET_outdir))
RULE_OREQS += $(call MAKE_EncodeWord,$(NUGET_SHARED))

define RULE_COMMANDS
	rm -rf $(call SYSTEM_ShellEscape,$(NUGET_outdir))/*
	mkdir $(call SYSTEM_ShellEscape,$(NUGET_outdir))/work
	cp $(call SYSTEM_ShellEscape,$(NUGET_SHARED)) $(call SYSTEM_ShellEscape,$(NUGET_outdir))/work/nuget.exe
	$(call DOTNETFRAMEWORK_Exec,$(NUGET_outdir)/work/nuget.exe) install $(call SYSTEM_ShellEscape,$(NUGET_packagename)) -Version $(NUGET_packageversion) -OutputDirectory $(call SYSTEM_ShellEscape,$(call SYSTEM_WinPathOnWin,$(NUGET_outdir)/work))
	mv -v $(call SYSTEM_ShellEscape,$(NUGET_outdir))/work/$(NUGET_packagename).$(NUGET_packageversion)/* $(call SYSTEM_ShellEscape,$(NUGET_outdir))/
	rm -rf $(call SYSTEM_ShellEscape,$(NUGET_outdir))/work
	touch $(call SYSTEM_ShellEscape,$(NUGET_dotfile))
endef

$(call PROJ_Rule)

