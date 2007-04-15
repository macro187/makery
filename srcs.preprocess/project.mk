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


# NOTE: SRCS_files and SRCS_files_preq must already be set up before this
# module gets called


$(call PROJ_DeclareVar,SRCS_PREPROCESS_pipeline)
SRCS_PREPROCESS_pipeline_DESC ?= Srcs variable list (append-only list)
SRCS_PREPROCESS_pipeline_VALIDATE ?= Required


# Hook existing SRCS_* to beginning of pipeline
$(call PROJ_DeclareTargetVar,SRCS_PREPROCESS_infiles)
SRCS_PREPROCESS_infiles_DESC ?= Input source code files (list)
$(eval SRCS_PREPROCESS_infiles = $(value SRCS_files))


$(call PROJ_DeclareVar,SRCS_PREPROCESS_infiles_preq)
SRCS_PREPROCESS_infiles_preq_DESC ?= Prerequisite version of _infiles (list)
$(eval SRCS_PREPROCESS_infiles_preq = $(value SRCS_files_preq))


SRCS_PREPROCESS_pipeline += SRCS_PREPROCESS_infiles


# Hook the end of the pipeline to SRCS_*
SRCS_files = $($(lastword $(SRCS_PREPROCESS_pipeline)))
SRCS_files_preq = $($(lastword $(SRCS_PREPROCESS_pipeline))_preq)

