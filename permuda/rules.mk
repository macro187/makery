# ------------------------------------------------------------------------------
# Copyright (c) 2010, 2011, 2012
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


RULE_TARGET := $(PERMUDA_preq)
RULE_REQS := $(PERMUDA_srcpreq)
RULE_REQS += $(call PROJ_GetVar,RUN_reqs,$(PERMUDA_PROJ))
RULE_OREQ := $(PERMUDA_dir)


define RULE_COMMANDS
	@echo ""
	@echo "=> Cleaning old output files..."
	rm -rf $$(call SYSTEM_ShellEscape,$$(PERMUDA_dir))/*
	@echo "=> ...done"
	@echo ""
	@echo "=> Making subdirs..."
	$$(foreach dir,$$(PERMUDA_subdirs),$$(MAKE_CHAR_NEWLINE)	mkdir -p $$(PERMUDA_dir)/$$(call MAKE_DecodeWord,$$(dir)))
	@echo "=> ...done"
	@echo ""
	@echo "=> Running Permuda..."
	$(call PROJ_GetVar,RUN_run,$(PERMUDA_PROJ)) $(MAKE_CHAR_BS)
	$(call SYSTEM_ShellEscape,$(call RUN_ArgPathAbs,$(PERMUDA_srcdir),$(PERMUDA_PROJ))) $(MAKE_CHAR_BS)
	$$(foreach src,$$(PERMUDA_srcs),$$(call PROJ_RuleNewLine,$$(call SYSTEM_ShellEscape,$$(call RUN_ArgPath,$$(call MAKE_DecodeWord,$$(src)),$$(PERMUDA_PROJ))))) $(MAKE_CHAR_BS)
	$(call SYSTEM_ShellEscape,$(call RUN_ArgPathAbs,$(PERMUDA_dir),$(PERMUDA_PROJ)))
	@echo "=> ...done"
	@echo ""
	@echo "=> Updating dotfile..."
	touch $$(PERMUDA_preq)
	@echo "=> ...done"
endef

$(call PROJ_Rule)

