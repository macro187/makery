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


# Require the Resbian program
PROJ_required += $(call MAKE_EncodeWord,$(DOTNET_RESBIAN_PROJ))


$(call PROJ_DeclareVar,DOTNET_RESBIAN_srcdir)
DOTNET_RESBIAN_srcdir_DESC ?= Resource source directory, absolute
DOTNET_RESBIAN_srcdir_DEFAULT = $(PROJ_dir)/res


$(call PROJ_DeclareVar,DOTNET_RESBIAN_srcs)
DOTNET_RESBIAN_srcs_DESC ?= Resource source files (relative to source dir) (list)
DOTNET_RESBIAN_srcs_DEFAULT = \
$(shell \
test -d $(call SYSTEM_ShellEscape,$(DOTNET_RESBIAN_srcdir)) \
&& cd $(call SYSTEM_ShellEscape,$(DOTNET_RESBIAN_srcdir)) \
&& find * -maxdepth 1 -type f \
| $(SYSTEM_SHELL_CLEANPATH) \
| $(SYSTEM_SHELL_ENCODEWORD) \
)


$(call PROJ_DeclareVar,DOTNET_RESBIAN_srcs_abs)
DOTNET_RESBIAN_srcs_abs_DESC ?= (read-only) Resource source files (absolute) (list)
DOTNET_RESBIAN_srcs_abs = \
$(foreach src,$(DOTNET_RESBIAN_srcs),$(call MAKE_EncodeWord,$(DOTNET_RESBIAN_srcdir))/$(src))


$(call PROJ_DeclareVar,DOTNET_RESBIAN_cultures)
DOTNET_RESBIAN_cultures_DESC ?= \
(read-only) Cultures for which resource sources exist (. = neutral) (list)
DOTNET_RESBIAN_cultures = \
$(sort $(call MAKE_PathParentName,$(DOTNET_RESBIAN_srcs)))


$(call PROJ_DeclareVar,DOTNET_RESBIAN_outdir)
DOTNET_RESBIAN_outdir_DESC ?= Directory to output .resources files to
DOTNET_RESBIAN_outdir_DEFAULT = $(OUT_base)/dotnet_resources

OUT_all += $(call MAKE_EncodeWord,$(DOTNET_RESBIAN_outdir))


$(call PROJ_DeclareVar,DOTNET_RESBIAN_outfiles)
DOTNET_RESBIAN_outfiles_DESC ?= (read-only) Output .resources files (list)
DOTNET_RESBIAN_outfiles = \
$(foreach c,$(DOTNET_RESBIAN_cultures),$(foreach t,$(call DOTNET_RESBIAN_GetTypes,$(c)),$(call MAKE_EncodeWord,$(call DOTNET_RESBIAN_GetOutfile,$(c),$(t)))))

# Add Resbian outfiles to DOTNET_resources for embedding into the dotnet binary
DOTNET_resources += $(DOTNET_RESBIAN_outfiles)

