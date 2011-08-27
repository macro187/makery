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


$(call PROJ_DeclareVar,PROJ_vars)
PROJ_vars_DESC ?= (internal) Names of all project-specific variables (list)


$(call PROJ_DeclareVar,PROJ_targetvars)
PROJ_targetvars_DESC ?= (internal) Names of all target-time variables (list)


$(call PROJ_DeclareVar,PROJ_ismain)
PROJ_ismain := $(if $(PROJ_PROJECTS),,1)
PROJ_ismain_DESC ?= Is this the main project? (ie. where make was run)


$(call PROJ_DeclareVar,PROJ_dir)
ifeq ($(PROJ_ismain),)
ifeq ($(PROJ_dir),)
$(error BUG - Non-main project, PROJ_dir should have been pre-set)
endif
endif
PROJ_dir_DESC ?= \
The absolute path of the project directory, serves as its unique id
PROJ_dir_DEFAULT := $(shell $(PWD) | $(SYSTEM_SHELL_CLEANPATH))


$(call PROJ_DeclareVar,PROJ_dir_asword)
PROJ_dir_asword_DESC ?= (internal) PROJ_dir encoded as word
PROJ_dir_asword := $(call MAKE_EncodeWord,$(PROJ_dir))

# Add to global "projects processed" list
PROJ_PROJECTS += $(PROJ_dir_asword)


$(call PROJ_DeclareVar,PROJ_required)
PROJ_required_DESC ?= Other projects that (may be) required by this one (list)


$(call PROJ_DeclareVar,PROJ_required_abs)
PROJ_required_abs_DESC ?= \
(read-only) Absolute paths to projects that (may be) required by this one (list)
PROJ_required_abs_DEFAULT = \
$(MAKERY_TraceBegin)$(foreach proj,$(PROJ_required),$(call MAKE_EncodeWord,$(call PROJ_LocateFromHere,$(call MAKE_DecodeWord,$(proj)))))$(MAKERY_TraceEnd)

