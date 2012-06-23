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


# ------------------------------------------------------------------------------
# OUT Module
# Provides work/output directories
#
# Usage:
# 1. Make a project variable for your output directory and set it to whatever
#    you want, usually under $(OUT_base)
# 2. Append your project variable to OUT_all
# 3. OREQ your output directory for any targets that need it
# 4. Hook up $(PROJ_dir)/out-clean to $(PROJ_dir)/clean to have your
#    output dirs removed for you
#
# Example:
#      # In project.mk:
#      ...
#      MYMODULE_myoutdir = $(OUT_base)/myoutdir
#      ...
#      $(OUT_all) += $(MYMODULE_myoutdir)
#      ...
#
#      # In rules.mk
#      ...
#      TMP_OREQS += $(call MAKE_EncodeWord,$(MYMODULE_myoutdir))
#      ...
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

