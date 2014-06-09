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


MODULES_use_DESC ?= \
Modules that the project says will build it (list)
$(call PROJ_DeclareVar,MODULES_use)


MODULES_proj_DESC ?= \
(internal) List of modules that have been processed for this project so far
$(call PROJ_DeclareVar,MODULES_proj)


MODULES_outdirs_DESC ?= \
(internal) All per-module output directories
$(call PROJ_DeclareVar,MODULES_outdirs)
MODULES_outdirs = $(foreach m,$(MODULES_proj),$($(call MODULES_VariablePrefix,$(m))_outdir))


# Variables to hold module dependencies
#
PROJ_vars += $(foreach mod,$(MODULES_proj),MODULES_requiredby_$(call MAKE_DecodeWord,$(mod)))

