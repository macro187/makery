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


OUT_base_DESC := \
(internal) Output directory
$(call PROJ_DeclareVar,OUT_base)
OUT_base_DEFAULT = $(PROJ_dir)/out

ifdef MAKERYOUT
ifeq ($(call SYSTEM_DirExists,$(MAKERYOUT)),)
$(error Non-existent MAKERYOUT directory specified: '$(MAKERYOUT)')
endif
OUT_base_DEFAULT = $(call SYSTEM_DirToAbs,$(MAKERYOUT))/$(PROJ_name)
endif


OUT_cleantarget_DESC := \
Phony target to clean output directory
$(call PROJ_DeclareVar,OUT_cleantarget)
OUT_cleantarget_DEFAULT = $(OUT_base)/out/clean


# Hook to clean
#
CLEAN_reqs += $(call MAKE_EncodeWord,$(OUT_cleantarget))

