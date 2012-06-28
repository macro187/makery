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


DOTNET_COPYLIBS_outdir_DESC := \
(readonly) Directory in which to collect required library files
$(call PROJ_DeclareVar,DOTNET_COPYLIBS_outdir)
DOTNET_COPYLIBS_outdir_DEFAULT = $(OUT_base)/dotnet-copylibs

OUT_all += $(call MAKE_EncodeWord,$(DOTNET_COPYLIBS_outdir))


DOTNET_COPYLIBS_dotfile_DESC ?= \
(readonly) Dotfile representing collection of required library files
$(call PROJ_DeclareVar,DOTNET_COPYLIBS_dotfile)
DOTNET_COPYLIBS_dotfile_DEFAULT = $(OUT_base)/_dotnet-copylibs

