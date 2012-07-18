# ------------------------------------------------------------------------------
# Copyright (c) 2012
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


DOTNETREFERENCES_proj_DESC := \
(append-only) Names of dotnetassembly library projects to reference (list)
$(call PROJ_DeclareVar,DOTNETREFERENCES_proj)


DOTNETREFERENCES_gac_DESC := \
(append-only) Filenames of GAC .DLLs to reference (list)
$(call PROJ_DeclareVar,DOTNETREFERENCES_gac)


DOTNETREFERENCES_nostdlib_DESC := \
Avoid referencing mscorlib.dll?
$(call PROJ_DeclareVar,DOTNETREFERENCES_nostdlib)
DOTNETREFERENCES_nostdlib_OPTIONS = 0 1


DOTNETREFERENCES_outdir_DESC := \
Directory to output references assembly files
$(call PROJ_DeclareVar,DOTNETREFERENCES_outdir)
DOTNETREFERENCES_outdir_DEFAULT = $(OUT_base)/dotnetreferences


DOTNETREFERENCES_dotfile_DESC := \
(readonly) Dotfile representing copied referenced assembly files
$(call PROJ_DeclareVar,DOTNETREFERENCES_dotfile)
DOTNETREFERENCES_dotfile = $(OUT_base)/_dotnetreferences


DOTNETREFERENCES_proj_primary_recursive_DESC := \
(readonly) Absolute paths of primary assembly files from project references, recursive (list)
$(call PROJ_DeclareTargetVar,DOTNETREFERENCES_proj_primary_recursive)
DOTNETREFERENCES_proj_primary_recursive = \
$(sort $(call PROJ_GetMultiRecursive,DOTNETASSEMBLY_primary_abs,DOTNETREFERENCES_proj))


DOTNETREFERENCES_gac_recursive_DESC := \
(readonly) Referenced GAC libraries from this and referenced projects, recursive (list)
$(call PROJ_DeclareTargetVar,DOTNETREFERENCES_gac_recursive)
DOTNETREFERENCES_gac_recursive = \
$(sort $(DOTNETREFERENCES_gac) $(call PROJ_GetMultiRecursive,DOTNETREFERENCES_gac,DOTNETREFERENCES_proj))


# Hook up to proj
#
PROJ_required += $(DOTNETREFERENCES_proj)


# Hook up to out
#
OUT_all += $(call MAKE_EncodeWord,$(DOTNETREFERENCES_outdir))


