# ------------------------------------------------------------------------------
# Copyright (c) 2007 Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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
# OUTDIRS Module
# Provides work/output directories
#
# Usage:
# 1. Make a project variable for your output directory and set it to whatever
#    you want, usually under $(OUTDIRS_base)
# 2. Append your project variable to OUTDIRS_all
# 3. OREQ your output directory for any targets that need it
# 4. Hook up $(PROJ_dir)/outdirs-clean to $(PROJ_dir)/clean to have your
#    output dirs removed for you
#
# Example:
#      # In project.mk:
#      ...
#      MYMODULE_myoutdir = $(OUTDIRS_base)/myoutdir
#      ...
#      $(OUTDIRS_all) += $(MYMODULE_myoutdir)
#      ...
#
#      # In rules.mk
#      ...
#      TMP_OREQS += $(call MAKE_EncodeWord,$(MYMODULE_myoutdir))
#      ...
# ------------------------------------------------------------------------------


$(call PROJ_DeclareVar,OUTDIRS_all)
OUTDIRS_all_DESC = All output directories (list)


$(call PROJ_DeclareVar,OUTDIRS_base)
OUTDIRS_base_DESC = Base output directory
OUTDIRS_base_DEFAULT = $(PROJ_dir)/out

OUTDIRS_all += $(call MAKE_EncodeWord,$(OUTDIRS_base))


$(call PROJ_DeclareVar,OUTDIRS_cleantarget)
OUTDIRS_cleantarget_DESC = The phony target to clean all output directories
OUTDIRS_cleantarget_DEFAULT = $(PROJ_dir)/outdirs-clean

# Hook to clean target
CLEANABLE_reqs += $(call MAKE_EncodeWord,$(OUTDIRS_cleantarget))

