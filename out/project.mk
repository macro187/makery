# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012
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

$(call PROJ_DeclareVar,OUT_all)
OUT_all_DESC ?= All output directories (list)


$(call PROJ_DeclareVar,OUT_base)
OUT_base_DESC ?= Base output directory
OUT_base_DEFAULT = $(PROJ_dir)/out

OUT_all += $(call MAKE_EncodeWord,$(OUT_base))


$(call PROJ_DeclareVar,OUT_cleantarget)
OUT_cleantarget_DESC ?= The phony target to clean all output directories
OUT_cleantarget_DEFAULT = $(PROJ_dir)/out-clean

# Hook to clean target
CLEAN_reqs += $(call MAKE_EncodeWord,$(OUT_cleantarget))

