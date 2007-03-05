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


$(call PROJ_DeclareVar,DOTNET_COPYLIBS_outdir)
DOTNET_COPYLIBS_outdir_DESC = Directory to output binaries + required libs
DOTNET_COPYLIBS_outdir_DEFAULT = $(OUTDIRS_base)/dotnet_copylibs

OUTDIRS_all += $(call MAKE_EncodeWord,$(DOTNET_COPYLIBS_outdir))


$(call PROJ_DeclareVar,DOTNET_COPYLIBS_dotfile)
DOTNET_COPYLIBS_dotfile_DESC = \
(internal) Temp file representing binaries + requied libs
DOTNET_COPYLIBS_dotfile_DEFAULT = $(OUTDIRS_base)/_dotnet_copylibs

