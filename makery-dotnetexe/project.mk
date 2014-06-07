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


DOTNETEXE_dotfile_DESC := \
(readonly) Dotfile representing in-place runnable executable
$(call PROJ_DeclareVar,DOTNETEXE_dotfile)
DOTNETEXE_dotfile_DEFAULT = $(OUT_dir)/_dotnetexe


DOTNETEXE_outdir_DESC := \
(readonly) Directory to build runnable version of executable
$(call PROJ_DeclareVar,DOTNETEXE_outdir)
DOTNETEXE_outdir_DEFAULT = $(OUT_dir)/dotnetexe


DOTNETEXE_exe_DESC ?= \
(readonly) Absolute path to the program runnable in-place
$(call PROJ_DeclareVar,DOTNETEXE_exe)
DOTNETEXE_exe = $(DOTNETEXE_outdir)/$(DOTNETASSEMBLY_primary)


# Hook up to run
#
RUN_reqs += \
$(call MAKE_EncodeWord,$(DOTNETEXE_dotfile))

RUN_run = \
$(DOTNETFRAMEWORK_exec) $(call SYSTEM_ShellEscape,$(DOTNETEXE_exe))

RUN_argpathfunc = \
$(if $(filter ms,$(DOTNET_implementation)),SYSTEM_WinPath,MAKE_Identity)

RUN_argpathabsfunc = \
$(if $(filter ms,$(DOTNET_implementation)),SYSTEM_WinPathAbs,MAKE_Identity)

