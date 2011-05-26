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


CONFIG_DeclareField = \
$(eval $(call CONFIG_DeclareField_TEMPLATE,$(1)))


define CONFIG_DeclareField_TEMPLATE
CONFIG_fields += $(1)

PROJ_vars += $(1)_ALL
PROJ_vars += $(1)_MASKS
PROJ_vars += $$(foreach v,$$($(1)_MASKS),$(1)_MASK_$$(v))

PROJ_vars += $(1)_MASK
$(1)_MASK = $$(foreach m,$$($(1)_MASKS),$$($(1)_MASK_$$(m)))

PROJ_vars += $(1)_AVAIL
$(1)_AVAIL = $$(filter-out $$($(1)_MASK),$$($(1)_ALL))

$$(call PROJ_DeclareVar,$(1))
$(1) = $$(if $$(if $$($(call uc,$(1))),$$(filter $$($(call uc,$(1))),$$($(1)_AVAIL))),$$($(call uc,$(1))),$$(firstword $$($(1)_AVAIL)))

# TODO Declare and use all-uppercase global var (how to uppercase name?)
endef

