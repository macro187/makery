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


$(call PROJ_DeclareVar,RUNNABLE_target)
RUNNABLE_target_DESC ?= The phony runnable target
RUNNABLE_target_DEFAULT = $(PROJ_dir)/runnable


$(call PROJ_DeclareVar,RUNNABLE_reqs)
RUNNABLE_reqs_DESC ?= Prerequisites for the project to be runnable in-place (list)


$(call PROJ_DeclareVar,RUNNABLE_run)
RUNNABLE_run_DESC ?= Pre-escaped shell command to run the project in-place


$(call PROJ_DeclareVar,RUNNABLE_argpathfunc)
RUNNABLE_argpathfunc_DESC ?= Name of function to be called on all command-line arguments that are path fragments
RUNNABLE_argpathfunc_DEFAULT = MAKE_Identity


$(call PROJ_DeclareVar,RUNNABLE_argpathabsfunc)
RUNNABLE_argpathabsfunc_DESC ?= Name of function to be called on all command-line arguments that are full paths
RUNNABLE_argpathabsfunc_DEFAULT = MAKE_Identity




# Hook "runnable" to "everything"
EVERYTHING_reqs += $(call MAKE_EncodeWord,$(RUNNABLE_target))

