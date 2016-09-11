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


$(call PROJ_DeclareVar,PROJ_vars)
PROJ_vars_DESC ?= (internal) Names of all project-specific variables (list)


$(call PROJ_DeclareVar,PROJ_targetvars)
PROJ_targetvars_DESC ?= (internal) Names of all target-time variables (list)


$(call PROJ_DeclareVar,PROJ_ismain)
PROJ_ismain := $(if $(PROJ_PROCESSED),,1)
PROJ_ismain_DESC ?= Is this the main project? (ie. where make was run)


PROJ_dir_DESC ?= \
The absolute path to the project
$(call PROJ_DeclareVar,PROJ_dir)
ifeq ($(PROJ_ismain),)
ifeq ($(PROJ_dir),)
$(error BUG - Non-main project, PROJ_dir should have been pre-set)
endif
endif
ifeq ($(strip $(PROJ_dir)),)
PROJ_dir := $(call MAKE_Shell,$(PWD))
endif


$(call PROJ_DeclareVar,PROJ_dir_asword)
PROJ_dir_asword_DESC ?= (internal) PROJ_dir encoded as word
PROJ_dir_asword := $(call MAKE_EncodeWord,$(PROJ_dir))


# Add the project to the global processed projects list
#
PROJ_PROCESSED += $(PROJ_dir_asword)


PROJ_name_DESC ?= \
Unique project name derived from project directory name
$(call PROJ_DeclareVar,PROJ_name)
PROJ_name := $(call MAKE_DecodeWord,$(notdir $(PROJ_dir_asword)))

ifneq ($(PROJ_name),$(call MAKE_EncodeWord,$(PROJ_name)))
$(error Project name '$(PROJ_name)' contains special characters)
endif


PROJ_required_DESC ?= \
Names of other projects that (may be) required by this one (list)
$(call PROJ_DeclareVar,PROJ_required)

