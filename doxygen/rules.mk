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


RULE_TARGET := $(DOXYGEN_target)
RULE_PHONY := 1
RULE_REQ := $(DOXYGEN_configfile)
RULE_REQDBYS := doxygenall
RULE_REQDBYS += $(if $(PROJ_ismain),doxygen)

$(call PROJ_Rule)



RULE_TARGET := $(DOXYGEN_configfile)
RULE_REQS := $(DOXYGEN_depends)
RULE_OREQ := $(DOXYGEN_outdir)

define RULE_COMMANDS
	@echo ""
	@echo "=> Cleaning old doxygen output..."
	rm -f $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	rm -rf $(call SYSTEM_ShellEscape,$(DOXYGEN_outdir))/*
	@echo "=> ...done"

	@echo ""
	@echo "=> Generating doxygen config file..."

# Outdir
	@echo "OUTPUT_DIRECTORY = \"$(DOXYGEN_outdir)\"" $(MAKE_CHAR_BS)
		> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))

# General options
	@echo "QUIET=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "CASE_SENSE_NAMES=NO" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))

# Parsing options
	@echo "JAVADOC_AUTOBRIEF=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "EXTRACT_ALL=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "EXTRACT_STATIC=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "EXTRACT_LOCAL_CLASSES=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))

# HTML options
	@echo "HTML_DYNAMIC_SECTIONS=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "GENERATE_TREEVIEW=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "SOURCE_BROWSER=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "OPTIMIZE_OUTPUT_JAVA=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "INLINE_INFO=NO" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "SORT_MEMBER_DOCS=NO" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "SORT_BRIEF_DOCS=NO" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "SHOW_USED_FILES=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "SHOW_DIRECTORIES=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "HIDE_SCOPE_NAMES=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "SEPARATE_MEMBER_PAGES=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "ALWAYS_DETAILED_SEC=NO" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))

# Graphviz options
ifneq ($$(DOXYGEN_DOT),)
	@echo "HAVE_DOT=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "DOT_MULTI_TARGETS=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "DOT_TRANSPARENT=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "DOT_CLEANUP=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "UML_LOOK=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "CLASS_GRAPH=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "GRAPHICAL_HIERARCHY=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "COLLABORATION_GRAPH=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "TEMPLATE_RELATIONS=YES" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
else
	@echo "HAVE_DOT=NO" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
endif

# Input files
	@echo "INPUT = \\" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	$$(foreach src,$$(DOXYGEN_srcs),$$(MAKE_CHAR_NEWLINE)	@echo "	\"$$(call MAKE_DecodeWord,$$(src))\" \\" >> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile)))
	@echo "" $(MAKE_CHAR_BS)
		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))

# Defines
# TODO Set defines to specific values (if provided)
$(if $(DOXYGEN_defines), \
$(MAKE_CHAR_NEWLINE)	@echo "PREDEFINED = \\" \
\$(MAKE_CHAR_NEWLINE)		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))\
\
$(foreach def,$(DOXYGEN_defines),\
$(MAKE_CHAR_NEWLINE)	@echo "	\"$(call MAKE_DecodeWord,$(def))=$(DOXYGEN_DEFINE_DEFAULT)\" \\" \
\$(MAKE_CHAR_NEWLINE)		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))\
)\
\
$(MAKE_CHAR_NEWLINE)	@echo "" \
\$(MAKE_CHAR_NEWLINE)		>> $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile)) \
)

	@echo "=> ...done"

ifneq ($$(DOXYGEN_DOXYGEN),)
	@echo ""
	@echo "=> Executing doxygen..."
	$(call SYSTEM_ShellEscape,$(DOXYGEN_DOXYGEN)) $(call SYSTEM_ShellEscape,$(DOXYGEN_configfile))
	@echo "=> ...done"
else
	@echo ""
	@echo "=> Doxygen not available, not generating documentation"
endif

endef

$(call PROJ_Rule)

