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


NUGETASSEMBLY_path_DESC ?= \
Path to assembly file(s) within the NuGet package
$(call PROJ_DeclareVar,NUGETASSEMBLY_path)
NUGETASSEMBLY_path_VALIDATE = Required


NUGETASSEMBLY_primaryfile_DESC ?= \
Filename of primary assembly file relative to NUGETASSEMBLY_path
$(call PROJ_DeclareVar,NUGETASSEMBLY_primaryfile)
NUGETASSEMBLY_primaryfile_VALIDATE = Required


NUGETASSEMBLY_useallfiles_DESC ?= \
Include all files under NUGETASSEMBLY_path?
$(call PROJ_DeclareVar,NUGETASSEMBLY_useallfiles)


NUGETASSEMBLY_extrafiles_DESC ?= \
Individual files under NUGETASSEMBLY_path to include (list)
$(call PROJ_DeclareVar,NUGETASSEMBLY_extrafiles)


DOTNETASSEMBLY_primary = $(NUGETASSEMBLY_primaryfile)

