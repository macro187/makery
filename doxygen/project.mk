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


$(call PROJ_DeclareVar,DOXYGEN_target)
DOXYGEN_target_DESC ?= The doxygen phony target
DOXYGEN_target_DEFAULT = $(PROJ_dir)/doxygen


$(call PROJ_DeclareVar,DOXYGEN_depends)
DOXYGEN_depends_DESC ?= \
(append-only) Prerequisites for generating doxygen documentation (list)


$(call PROJ_DeclareVar,DOXYGEN_srcs)
DOXYGEN_srcs_DESC ?= Source code files to document (list)

DOXYGEN_depends += $(DOXYGEN_srcs)


$(call PROJ_DeclareVar,DOXYGEN_defines)
DOXYGEN_defines_DESC ?= \
Preprocessor vars to treat as defined when parsing source files (list)

PROJ_vars += $(foreach d,$(DOXYGEN_defines),DOXYGEN_define_$(d))

# If you want a variable's value to be something other than
# DOXYGEN_DEFINE_DEFAULT, add it's varname and also do this:
#DOXYGEN_define_<VARNAME> = <VALUE>
#PROJ_vars += DOXYGEN_define_<VARNAME>


$(call PROJ_DeclareVar,DOXYGEN_outdir)
DOXYGEN_outdir_DESC ?= Directory to output documentation to
DOXYGEN_outdir_DEFAULT = $(OUTDIRS_base)/doxygen

OUTDIRS_all += $(call MAKE_EncodeWord,$(DOXYGEN_outdir))


$(call PROJ_DeclareVar,DOXYGEN_configfile)
DOXYGEN_configfile_DESC ?= (read-only) Output doxygen config file
DOXYGEN_configfile_DEFAULT = \
$(if $(DOXYGEN_srcs),$(DOXYGEN_outdir)/doxygen.config)


# Hook doxygen to the everything target
EVERYTHING_reqs += $(call MAKE_EncodeWord,$(DOXYGEN_target))

