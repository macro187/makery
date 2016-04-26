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


# Get the name of the module currently at the end of the preprocessor pipeline
#
SRCS_PREPROCESS_GetUpstream = \
$(lastword $(SRCS_PREPROCESS_pipeline))


# Get a preprocessor module's output root source code directory
#
# $1 - Preprocessor module name
#      default: SRCS_PREPROCESS_GetUpstream()
#
SRCS_PREPROCESS_GetDir = \
$(or $($(call MODULES_VariablePrefix,$(or $(1),$(call SRCS_PREPROCESS_GetUpstream)))_ppdir),$($(call MODULES_VariablePrefix,$(or $(1),$(call SRCS_PREPROCESS_GetUpstream)))_outdir))


# Get a preprocessor module's output source code files relative to
# SRCS_PREPROCESS_GetDir()
#
# $1 - Preprocessor module name
#      default: SRCS_PREPROCESS_GetUpstream()
#
SRCS_PREPROCESS_GetFiles = \
$(or $($(call MODULES_VariablePrefix,$(or $(1),$(call SRCS_PREPROCESS_GetUpstream)))_ppfiles),$(call MAKE_Shell,cd $(call SYSTEM_ShellEscape,$(call SRCS_PREPROCESS_GetDir,$(1))) && find * -type f | $(SYSTEM_SHELL_ENCODEWORD)))


# Get prerequisites representing a preprocessor module's output source code
# files
#
# $1 - Preprocessor module name
#      default: SRCS_PREPROCESS_GetUpstream()
#
SRCS_PREPROCESS_GetPreqs = \
$(or $($(call MODULES_VariablePrefix,$(or $(1),$(call SRCS_PREPROCESS_GetUpstream)))_pppreqs),$(call MAKE_EncodeWord,$($(call MODULES_VariablePrefix,$(or $(1),$(call SRCS_PREPROCESS_GetUpstream)))_dotfile)))

