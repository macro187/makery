# ------------------------------------------------------------------------------
# Copyright (c) 2010, 2011, 2012
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


# Require the Traitor program
PROJ_required += $(call MAKE_EncodeWord,$(TRAITOR_PROJ))


# upstream processor in the preprocessor pipeline
$(call PROJ_DeclareVar,TRAITOR_ppfrom)
TRAITOR_ppfrom_DESC ?= Upstream processor in preprocessor pipeline
TRAITOR_ppfrom_DEFAULT := $(lastword $(SRCS_PREPROCESS_pipeline))


# srcdir
$(call PROJ_DeclareVar,TRAITOR_srcdir)
TRAITOR_srcdir_DESC ?= Source code files root directory (read-only)
TRAITOR_srcdir_DEFAULT = $($(TRAITOR_ppfrom)_dir)


# srcs (target)
$(call PROJ_DeclareTargetVar,TRAITOR_srcs)
TRAITOR_srcs_DESC ?= Source code files relative to TRAITOR_srcdir (read-only)
TRAITOR_srcs = $($(TRAITOR_ppfrom)_rel)


# srcpreq
$(call PROJ_DeclareVar,TRAITOR_srcpreq)
TRAITOR_srcpreq_DESC ?= Source code files prerequisite files (read-only)
TRAITOR_srcpreq_DEFAULT = $($(TRAITOR_ppfrom)_preq)


# output dir
$(call PROJ_DeclareVar,TRAITOR_dir)
TRAITOR_dir_DESC ?= Directory to put processed source code file(s) in
TRAITOR_dir_DEFAULT = $(OUT_base)/traitor

OUT_all += $(call MAKE_EncodeWord,$(TRAITOR_dir))


# dotfile
$(call PROJ_DeclareVar,TRAITOR_preq)
TRAITOR_preq_DESC ?= Temp file representing traitor output file(s)
TRAITOR_preq_DEFAULT = $(TRAITOR_dir)/dotfile


# subdirs (target)
$(call PROJ_DeclareTargetVar,TRAITOR_subdirs)
TRAITOR_subdirs = $(filter-out ./,$(dir $(TRAITOR_srcs)))


# output files relative to TRAITOR_dir (target)
$(call PROJ_DeclareTargetVar,TRAITOR_rel)
TRAITOR_rel_DESC ?= Traitor output files relative to TRAITOR_dir
TRAITOR_rel = \
$(shell \
cd $(call SYSTEM_ShellEscape,$(TRAITOR_dir)) && find * -type f -name \*.cs \
| $(SYSTEM_SHELL_CLEANPATH) \
| $(SYSTEM_SHELL_ENCODEWORD) \
)


# hook to pipeline
SRCS_PREPROCESS_pipeline += TRAITOR


