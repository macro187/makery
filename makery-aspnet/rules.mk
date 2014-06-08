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


RULE_TARGET := $(ASPNET_dotfile)
RULE_REQ := $(DOTNETREFERENCES_dotfile)
RULE_OREQ := $(ASPNET_outdir)
RULE_REQDBY := $(HTDOCS_dotfile)

define RULE_COMMANDS
	cp -rf $(call SYSTEM_ShellEscape,$(DOTNETREFERENCES_outdir)) $(call SYSTEM_ShellEscape,$(HTDOCS_outdir)/bin)
	touch $(call SYSTEM_ShellEscape,$(ASPNET_dotfile))
endef

$(call PROJ_Rule)


