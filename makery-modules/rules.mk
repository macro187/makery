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

RULE_TARGETS := $(MODULES_outdirs)
RULE_OREQ := $(OUT_dir)
define RULE_COMMANDS
	mkdir -p $$(call SYSTEM_ShellEscape,$$@)
endef
$(call PROJ_Rule)


define MODULES_RULE_REQUIRES
$(call MAKE_EncodePath,$($(call MODULES_VariablePrefix,$(1))_dotfile)): \
$(foreach mod,$(MODULES_requiredby_$(1)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$($(call MODULES_VariablePrefix,$(mod))_dotfile)))
endef

$(foreach mod,$(MODULES_proj),$(if $(MODULES_requiredby_$(mod)),$(call MAKE_Eval,$(call MODULES_RULE_REQUIRES,$(mod)))))


MODULES_RULE_REQUIRES :=

