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


RULE_TARGET := $(SRCS_PREPROCESS_preq)
RULE_REQS := $(SRCS_PREPROCESS_srcpreq)
RULE_OREQ := $(SRCS_PREPROCESS_dir)


define RULE_COMMANDS
	@echo ""
	@echo "=> Cleaning old final source files..."
	rm -rf $$(call SYSTEM_ShellEscape,$$(SRCS_PREPROCESS_dir))/*
	@echo "=> ...done"
	@echo ""
	@echo "=> Cleaning old dotfile..."
	rm -f $(call SYSTEM_ShellEscape,$(SRCS_PREPROCESS_preq))
	@echo "=> ...done"
	@echo ""
	@echo "=> Making subdirs..."
	$$(foreach dir,$$(SRCS_PREPROCESS_subdirs),$$(MAKE_CHAR_NEWLINE)	mkdir -p $$(SRCS_PREPROCESS_dir)/$$(call MAKE_DecodeWord,$$(dir)))
	@echo "=> ...done"
	@echo ""
	@echo "=> Copying final source files..."
	$$(foreach src,$$(SRCS_PREPROCESS_srcs),$$(MAKE_CHAR_NEWLINE)	cp $$(call SYSTEM_ShellEscape,$$(SRCS_PREPROCESS_srcdir)/$$(call MAKE_DecodeWord,$$(src))) $$(call SYSTEM_ShellEscape,$$(SRCS_PREPROCESS_dir)/$$(call MAKE_DecodeWord,$$(src))))
	@echo "=> ...done"
	@echo ""
	@echo "=> Updating dotfile..."
	touch $(SRCS_PREPROCESS_preq)
	@echo "=> ...done"
endef

$(call PROJ_Rule)

