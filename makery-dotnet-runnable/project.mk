# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012
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


# ------------------------------------------------------------------------------
# NOTE: Assumes that you're generating executable output in the DOTNET module
# ------------------------------------------------------------------------------

DOTNET_RUNNABLE_dotfile_DESC := \
(readonly) Dotfile representing runnable in-place
$(call PROJ_DeclareVar,DOTNET_RUNNABLE_dotfile)
DOTNET_RUNNABLE_dotfile_DEFAULT = $(OUT_base)/_dotnet-runnable


DOTNET_RUNNABLE_outdir_DESC := \
(readonly) Directory to output runnable version of project
$(call PROJ_DeclareVar,DOTNET_RUNNABLE_outdir)
DOTNET_RUNNABLE_outdir_DEFAULT = $(OUT_base)/dotnet-runnable

OUT_all += $(call MAKE_EncodeWord,$(DOTNET_RUNNABLE_outdir))


DOTNET_RUNNABLE_exe_DESC ?= \
(readonly) Full path to the runnable program
$(call PROJ_DeclareVar,DOTNET_RUNNABLE_exe)
DOTNET_RUNNABLE_exe = $(DOTNET_RUNNABLE_outdir)/$(DOTNET_ASSEMBLY_primary)


# Hook up to the run module
#
RUN_reqs += \
$(call MAKE_EncodeWord,$(DOTNET_RUNNABLE_dotfile))

RUN_run = \
$(DOTNET_exec) $(call SYSTEM_ShellEscape,$(DOTNET_RUNNABLE_exe))

RUN_argpathfunc = \
$(if $(SYSTEM_ISWINDOWS)$(filter $(DOTNET_implementation),ms),SYSTEM_WinPath,MAKE_Identity)

RUN_argpathabsfunc = \
$(if $(SYSTEM_ISWINDOWS)$(filter $(DOTNET_implementation),ms),SYSTEM_WinPathAbs,MAKE_Identity)

