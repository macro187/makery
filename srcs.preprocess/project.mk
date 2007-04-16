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


# Hook the end of the pipeline to SRCS_*
SRCS_files = \
$(foreach f,$($(lastword $(SRCS_PREPROCESS_pipeline))_rel),$(call MAKE_EncodeWord,$($(lastword $(SRCS_PREPROCESS_pipeline))_dir))/$(f))

SRCS_files_preq = \
$($(lastword $(SRCS_PREPROCESS_pipeline))_preq)

