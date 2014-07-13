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


SRCS_PREPROCESS_pipeline_DESC := \
Preprocessor pipeline module names (append-only list)
$(call PROJ_DeclareVar,SRCS_PREPROCESS_pipeline)
SRCS_PREPROCESS_pipeline_VALIDATE = Required


# Hook the end of the pipeline to makery-srcs
#
SRCS_files = \
$(foreach f,$(call SRCS_PREPROCESS_GetFiles),$(call MAKE_EncodeWord,$(call SRCS_PREPROCESS_GetDir))/$(f))

SRCS_preqs = \
$(call SRCS_PREPROCESS_GetPreqs)

