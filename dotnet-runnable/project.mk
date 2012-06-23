# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009, 2010, 2011
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

# Need binaries + required libs to be runnable
RUNNABLE_reqs += $(call MAKE_EncodeWord,$(DOTNET_COPYLIBS_dotfile))


# The shell command to run the project's program
RUNNABLE_run = \
$(DOTNET_exec) $(call SYSTEM_ShellEscape,$(DOTNET_COPYLIBS_outdir)/$(call MAKE_DecodeWord,$(notdir $(call MAKE_EncodeWord,$(DOTNET_outfiles_main)))))


# Convert args to Windows paths if we're using the MS runtime on Windows
RUNNABLE_argpathfunc = \
$(if $(SYSTEM_ISWINDOWS)$(filter $(DOTNET_implementation),ms),SYSTEM_WinPath,MAKE_Identity)

RUNNABLE_argpathabsfunc = \
$(if $(SYSTEM_ISWINDOWS)$(filter $(DOTNET_implementation),ms),SYSTEM_WinPathAbs,MAKE_Identity)
