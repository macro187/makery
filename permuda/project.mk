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


# Require the Permuda program
PROJ_required += $(call MAKE_EncodeWord,$(PERMUDA_PROJ))


# upstream processor in the preprocessor pipeline
$(call PROJ_DeclareVar,PERMUDA_ppfrom)
PERMUDA_ppfrom_DESC ?= Upstream processor in preprocessor pipeline
PERMUDA_ppfrom_DEFAULT := $(lastword $(SRCS_PREPROCESS_pipeline))


# srcdir
$(call PROJ_DeclareVar,PERMUDA_srcdir)
PERMUDA_srcdir_DESC ?= Source code files root directory (read-only)
PERMUDA_srcdir_DEFAULT = $($(PERMUDA_ppfrom)_dir)


# srcs (target)
$(call PROJ_DeclareTargetVar,PERMUDA_srcs)
PERMUDA_srcs_DESC ?= Source code files relative to PERMUDA_srcdir (read-only)
PERMUDA_srcs = $($(PERMUDA_ppfrom)_rel)


# srcpreq
$(call PROJ_DeclareVar,PERMUDA_srcpreq)
PERMUDA_srcpreq_DESC ?= Source code files prerequisite files (read-only)
PERMUDA_srcpreq_DEFAULT = $($(PERMUDA_ppfrom)_preq)


# output dir
$(call PROJ_DeclareVar,PERMUDA_dir)
PERMUDA_dir_DESC ?= Directory to put output file(s) in
PERMUDA_dir_DEFAULT = $(OUT_base)/permuda

OUT_all += $(call MAKE_EncodeWord,$(PERMUDA_dir))


# dotfile
$(call PROJ_DeclareVar,PERMUDA_preq)
PERMUDA_preq_DESC ?= Temp file representing output file(s)
PERMUDA_preq_DEFAULT = $(PERMUDA_dir)/dotfile


# subdirs (target)
$(call PROJ_DeclareTargetVar,PERMUDA_subdirs)
PERMUDA_subdirs = $(filter-out ./,$(dir $(PERMUDA_srcs)))


# output files relative to PERMUDA_dir (target)
$(call PROJ_DeclareTargetVar,PERMUDA_rel)
PERMUDA_rel_DESC ?= Permuda output files relative to PERMUDA_dir
PERMUDA_rel = \
$(shell \
cd $(call SYSTEM_ShellEscape,$(PERMUDA_dir)) && find * -type f -name \*.cs \
| $(SYSTEM_SHELL_CLEANPATH) \
| $(SYSTEM_SHELL_ENCODEWORD) \
)


# hook to pipeline
SRCS_PREPROCESS_pipeline += PERMUDA


