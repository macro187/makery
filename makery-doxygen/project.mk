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


DOXYGEN_srcs_DESC := \
Source code files to document (list)
$(call PROJ_DeclareTargetVar,DOXYGEN_srcs)


DOXYGEN_defines_DESC := \
Preprocessor vars to treat as defined when parsing source files (list)
#
# Preprocessor variables default to DOXYGEN_DEFINE_DEFAULT.  To set a
# preproessor variable to something else:
#
#   DOXYGEN_define_<VARNAME> = <VALUE>
#
$(call PROJ_DeclareVar,DOXYGEN_defines)

PROJ_vars += $(foreach d,$(DOXYGEN_defines),DOXYGEN_define_$(d))


DOXYGEN_outdir_html_DESC := \
Directory to output html documentation to
$(call PROJ_DeclareVar,DOXYGEN_outdir_html)
DOXYGEN_outdir_html_DEFAULT = $(DOXYGEN_outdir)/html


DOXYGEN_configfile_DESC := \
(read-only) Output doxygen config file
$(call PROJ_DeclareVar,DOXYGEN_configfile)
DOXYGEN_configfile = $(DOXYGEN_outdir)/doxygen.config


DOXYGEN_tagfile_DESC := \
(read-only) Output doxygen tag file
$(call PROJ_DeclareVar,DOXYGEN_tagfile)
DOXYGEN_tagfile_DEFAULT = $(DOXYGEN_outdir)/$(PROJ_name).tag


DOXYGEN_tagprojects_DESC := \
(append-only) Projects whose doxygen documentation should be referenced (list)
$(call PROJ_DeclareVar,DOXYGEN_tagprojects)


PROJ_required += $(DOXYGEN_tagprojects)

