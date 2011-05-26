# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011
# Ron MacNeil <macro187 AT users DOT sourceforge DOT net>
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


#
# A preprocessor module must implement variables according to the following
# patten (<PP> is the prefix that the module adds to _pipeline):
#
# <PP>_dir      - Common root directory of source code files
# <PP>_rel      - Source code files relative to <PP>_dir
#               - Assumed to be target-time
# <PP>_preq     - Files that represent the source code files for prerequisites
#                 purposes (absolute paths)
#
$(call PROJ_DeclareVar,SRCS_PREPROCESS_pipeline)
SRCS_PREPROCESS_pipeline_DESC ?= Preprocessor list (append-only list)
SRCS_PREPROCESS_pipeline_VALIDATE ?= Required


$(call PROJ_DeclareVar,SRCS_PREPROCESS_ppfrom)
SRCS_PREPROCESS_ppfrom_DESC ?= Upstream processor in preprocessor pipeline
SRCS_PREPROCESS_ppfrom_DEFAULT = $(lastword $(SRCS_PREPROCESS_pipeline))


$(call PROJ_DeclareVar,SRCS_PREPROCESS_srcdir)
SRCS_PREPROCESS_srcdir_DESC ?= Source code files root directory (read-only)
SRCS_PREPROCESS_srcdir_DEFAULT = $($(SRCS_PREPROCESS_ppfrom)_dir)


$(call PROJ_DeclareTargetVar,SRCS_PREPROCESS_srcs)
SRCS_PREPROCESS_srcs_DESC ?= \
Source code files relative to SRCS_PREPROCESS_srcdir (read-only)
SRCS_PREPROCESS_srcs = $($(SRCS_PREPROCESS_ppfrom)_rel)


$(call PROJ_DeclareVar,SRCS_PREPROCESS_srcpreq)
SRCS_PREPROCESS_srcpreq_DESC ?= Source code files prerequisite files (read-only)
SRCS_PREPROCESS_srcpreq_DEFAULT = $($(SRCS_PREPROCESS_ppfrom)_preq)


$(call PROJ_DeclareVar,SRCS_PREPROCESS_dir)
SRCS_PREPROCESS_dir_DESC ?= Directory to put final source files in
SRCS_PREPROCESS_dir_DEFAULT = $(OUTDIRS_base)/srcs

OUTDIRS_all += $(call MAKE_EncodeWord,$(SRCS_PREPROCESS_dir))


$(call PROJ_DeclareVar,SRCS_PREPROCESS_preq)
SRCS_PREPROCESS_preq_DESC ?= Temp file representing final source files
SRCS_PREPROCESS_preq_DEFAULT = $(OUTDIRS_base)/srcs_dotfile


$(call PROJ_DeclareTargetVar,SRCS_PREPROCESS_subdirs)
SRCS_PREPROCESS_subdirs = $(filter-out ./,$(dir $(SRCS_PREPROCESS_srcs)))


$(call PROJ_DeclareTargetVar,SRCS_PREPROCESS_rel)
SRCS_PREPROCESS_rel_DESC ?= Final source files relative to SRCS_PREPROCESS_dir
SRCS_PREPROCESS_rel = \
$(shell \
cd $(call SYSTEM_ShellEscape,$(SRCS_PREPROCESS_dir)) && find * -type f \
| $(SYSTEM_SHELL_CLEANPATH) \
| $(SYSTEM_SHELL_ENCODEWORD) \
)



# Hook the end of the pipeline to SRCS_*
SRCS_files = \
$(foreach f,$(SRCS_PREPROCESS_srcs),$(call MAKE_EncodeWord,$(SRCS_PREPROCESS_srcdir))/$(f))

SRCS_files_preq = $(SRCS_PREPROCESS_srcpreq)

