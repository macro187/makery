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


RULE_TARGET := $(RUN_target)
RULE_PHONY := 1
RULE_REQS := $(RUN_reqs)
RULE_REQDBYS := runnableall
RULE_REQDBYS += $(if $(PROJ_ismain),runnable)
RULE_REQDBYS += $(EVERYTHING_dotfile)

$(call PROJ_Rule)



RULE_TARGET := $(PROJ_dir)/run
RULE_PHONY := 1
RULE_REQ := $(RUN_target)
RULE_REQDBYS := runall
RULE_REQDBYS += $(if $(PROJ_ismain),run)
RULE_REQDBYS += $(EVERYTHING_dotfile)

define RULE_COMMANDS
ifneq ($$(RUN_run),)
	$$(RUN_run)
else
	@echo ""
	@echo "=> No RUN_run command defined, unable to run"
endif
endef

$(call PROJ_Rule)

