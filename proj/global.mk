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


# ------------------------------------------------------------------------------
# List of Projects Processed
# ------------------------------------------------------------------------------

PROJ_PROJECTS :=



# ------------------------------------------------------------------------------
# Support for persistent project variables
# ------------------------------------------------------------------------------

# Generate a persistent variable name a specified variable from a specified
# project
#
# $1 Variable name
# $2 PROJ_dir

PROJ_PersistentName = \
PROJ_PERSISTENT__$(call MAKE_EncodeWord,$(2))__$(call MAKE_EncodeWord,$(1))

# (internal) Same, but assumes pre-MAKE_EncodeWord'd args
PROJ_PersistentNameUnsafe = \
PROJ_PERSISTENT__$(2)__$(1)



# Get the value of a specified variable from a specified project
# - Can only really be used after all projects have been processed ie. in
#   targets
#
# $1 Variable name
# $2 PROJ_dir

PROJ_GetVar = \
$($(call PROJ_PersistentName,$(1),$(2)))


# Get the values of a specified variable from all projects listed in a second
# variable, recursively
# - Values are sorted with duplicates removed
# - Only really works after all projects have been processed ie. in targets
#
# $1 Variable name
# $2 Project list variable name
# $3 PROJ_dir (optional, defaults to current)
#
# Eg.
#
#   $(call PROJ_GetVarRecursive,MyVar,PROJ_required)
#
# ...gets the value of $(MyVar) from all required projects, plus all their
# required projects, and so on.

# For single-value variables
PROJ_GetVarRecursive = \
$(sort \
$(foreach proj,$(call PROJ_GetVar,$(2),$(if $(3),$(3),$(PROJ_dir))), \
$(call MAKE_EncodeWord,$(call PROJ_GetVar,$(1),$(call MAKE_DecodeWord,$(proj)))) \
$(call PROJ_GetVarRecursive,$(1),$(2),$(call MAKE_DecodeWord,$(proj))) \
) \
)

# For list variables
PROJ_GetMultiRecursive = \
$(sort \
$(foreach proj,$(call PROJ_GetVar,$(2),$(if $(3),$(3),$(PROJ_dir))), \
$(call PROJ_GetVar,$(1),$(call MAKE_DecodeWord,$(proj))) \
$(call PROJ_GetMultiRecursive,$(1),$(2),$(call MAKE_DecodeWord,$(proj))) \
) \
)



# ------------------------------------------------------------------------------
# "Declare" a project variable
# $1 - Variable name
#
# Remarks:
#   This function is only valid in a module's project.mk
#
# Usage:
#   $(call PROJ_DeclareVar,PKGNAME_varname)
#   PKGNAME_varname_DEFAULT = (default value) (optional)
#   PKGNAME_varname_DESC = (description) (optional)
# ------------------------------------------------------------------------------

PROJ_DeclareVar = \
$(eval $(call PROJ_DeclareVar_TEMPLATE,$(1)))

define PROJ_DeclareVar_TEMPLATE
PROJ_vars += $(1)_DESC
PROJ_vars += $(1)_DEFAULT
PROJ_vars += $(1)
ifeq ($$($(1)),)
$(1) = $$($(1)_DEFAULT)
endif
endef



# ------------------------------------------------------------------------------
# Clear project variables
# ------------------------------------------------------------------------------

PROJ_ClearVars = \
$(eval $(PROJ_TEMPLATE_CLEARVARS))

define \
PROJ_TEMPLATE_CLEARVARS
$(foreach varname,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(varname) =#)
endef



# ------------------------------------------------------------------------------
# Process required projects
# ------------------------------------------------------------------------------

PROJ_ProcessRequired = \
$(eval $(PROJ_TEMPLATE_PROCESSREQUIRED))

#$(if $(MAKERY_DEBUG), \
#$(warning $(call MAKE_Message,PROCESSREQUIRED$(MAKE_CHAR_NEWLINE)$(PROJ_TEMPLATE_PROCESSREQUIRED))) \
#) \


define \
PROJ_TEMPLATE_PROCESSREQUIRED

# Flatten PROJ_vars
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) := $$($(v))#)

# Persist PROJ_vars
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(call PROJ_PersistentNameUnsafe,$(v),$(PROJ_dir_asword)) := $$($(v))#)

# Clear vars
$(PROJ_TEMPLATE_CLEARVARS)

# Make sure all required projects actually exist
$(PROJ_TEMPLATE_CHECKREQUIRED)

# Include if not already included
$(foreach p,$(PROJ_required),$(call PROJ_TEMPLATE_IncludeRequired,$(call MAKE_DecodeWord,$(p))))

# Restore vars
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) := $$($(call PROJ_PersistentNameUnsafe,$(v),$(PROJ_dir_asword)))#)

endef


define \
PROJ_TEMPLATE_CHECKREQUIRED
$(foreach proj,$(PROJ_required),$(MAKE_CHAR_NEWLINE)ifneq ($$(shell ((cd $(call SHELL_Escape,$(PROJ_dir)) && test -d $(call SHELL_Escape,$(call MAKE_DecodeWord,$(proj)))) && echo 1) || echo 0),1)$(MAKE_CHAR_NEWLINE)$$(error Required project '$(call MAKE_DecodeWord,$(proj))' directory does not exist)$(MAKE_CHAR_NEWLINE)endif#)
endef


define \
PROJ_TEMPLATE_IncludeRequired

PROJ_dir := $(shell cd $(call SHELL_Escape,$(PROJ_dir)) && cd $(call SHELL_Escape,$(call MAKE_DecodeWord,$(1))) && pwd)
ifeq ($$(filter $$(call MAKE_EncodeWord,$$(PROJ_dir)),$$(PROJ_PROJECTS)),)
include $$(call MAKE_EncodePath,$$(PROJ_dir))/Makefile
else
$$(warning Refraining from re-processing '$$(PROJ_dir)')
endif

endef



# ------------------------------------------------------------------------------
# Template for creating target-specific versions of project variables.
# This is because variables in targets are not expanded until the target is
# actually run, at which time the global versions will not exist anymore.
# ------------------------------------------------------------------------------

# target
define PROJ_TargetVars
$(eval $(call PROJ_TargetVars_TEMPLATE,$(1)))
endef

define PROJ_TargetVars_TEMPLATE
$(foreach varname,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(1)): $(varname) := $$($(call PROJ_PersistentName,$(varname),$(PROJ_dir)))#)
endef



# ------------------------------------------------------------------------------
# Template for clearing temporary target variables (TMP_*)
# ------------------------------------------------------------------------------

PROJ_ClearTmpVars = \
$(eval $(PROJ_TEMPLATE_CLEARTMPVARS))

define \
PROJ_TEMPLATE_CLEARTMPVARS
$(foreach varname,$(filter TMP_%,$(.VARIABLES)),$(MAKE_CHAR_NEWLINE)$(varname) :=#)
endef



# ------------------------------------------------------------------------------
# Target Boilerplate
#
# Usage:
#
# <copy and paste contents of PROJ_NEWTARGET_BOILERPLATE>
#
# TMP_TARGETS := ...
# TMP_REQS := ...
# TMP_OREQS := ...
# TMP_REQDBY := ...
# TMP_PHONY := ...
# 
# <copy and paste contents of PROJ_PRETARGET_BOILERPLATE>
#
#   <commands to build targets>
#
# <copy and paste contents of PROJ_POSTTARGET_BOILERPLATE>
#
# ------------------------------------------------------------------------------

# Copy+paste this inline
define PROJ_NEWTARGET_BOILERPLATE

# BEGIN NEW TARGET BOILERPLATE
$(PROJ_ClearTmpVars)
# END NEW TARGET BOILERPLATE

endef


# Copy+paste this inline
define PROJ_PRETARGET_BOILERPLATE

# BEGIN PRE-TARGET BOILERPLATE
ifneq ($(TMP_TARGETS),)
$(call MAKE_CallForEach,PROJ_TargetVars,$(TMP_TARGETS))
ifneq ($(TMP_REQDBY),)
$(call MAKE_CallForEach,MAKE_EncodePath,$(TMP_REQDBY)): \
$(call MAKE_CallForEach,MAKE_EncodePath,$(TMP_TARGETS))
endif
ifneq ($(TMP_PHONY),)
.PHONY: $(call MAKE_CallForEach,MAKE_EncodePath,$(TMP_TARGETS))
endif
$(call MAKE_CallForEach,MAKE_EncodePath,$(TMP_TARGETS)): \
$(call MAKE_CallForEach,MAKE_EncodePath,$(TMP_REQS)) \
$(if $(TMP_OREQS),| $(call MAKE_CallForEach,MAKE_EncodePath,$(TMP_OREQS)))
# END PRE-TARGET BOILERPLATE

endef


# Copy+paste this inline
define PROJ_POSTTARGET_BOILERPLATE

# BEGIN POST-TARGET BOILERPLATE
endif # TMP_TARGETS
# END POST-TARGET BOILERPLATE

endef



# ------------------------------------------------------------------------------
# Rule Generator
#
# RULE_TARGET
# RULE_TARGETS
# RULE_PHONY
# RULE_REQ
# RULE_REQS
# RULE_OREQ
# RULE_OREQS
# RULE_REQDBY
# RULE_REQDBYS
# ------------------------------------------------------------------------------


# Generates a project-specific rule given parameters specified in RULE_*
# variables
PROJ_Rule = \
$(if $(RULE_TARGET)$(RULE_TARGETS), \
$(if $(MAKERY_DEBUG), \
$(warning $(call MAKE_Message,Rule$(MAKE_CHAR_NEWLINE)$(PROJ_Rule_DUMP))) \
) \
$(eval $(call PROJ_Rule_TEMPLATE,$(call MAKE_CallForEach,MAKE_EncodePath,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)))))\
)


# Generate a dump of information about the rule
define PROJ_Rule_DUMP
Targets:$(if $(RULE_TARGETS)(RULE_TARGET),$(foreach t,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(t))),$(MAKE_CHAR_NEWLINE)(none))

Phony:
$(if $(RULE_PHONY),yes,no)

Prerequisites:$(if $(RULE_REQS)$(RULE_REQ),$(foreach p,$(RULE_REQS) $(call MAKE_EncodeWord,$(RULE_REQ)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(p))),$(MAKE_CHAR_NEWLINE)(none))

Order-only Prerequisites:$(if $(RULE_OREQS)$(RULE_OREQ),$(foreach p,$(RULE_OREQS) $(call MAKE_EncodeWord,$(RULE_OREQ)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(p))),$(MAKE_CHAR_NEWLINE)(none))

Prerequisite of:$(if $(RULE_REQDBYS)$(RULE_REQDBY),$(foreach r,$(RULE_REQDBYS) $(call MAKE_EncodeWord,$(RULE_REQDBY)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(r))),$(MAKE_CHAR_NEWLINE)(none))

Commands:
$(if $(RULE_COMMANDS),$(RULE_COMMANDS),(none))

Rule code:
$(call PROJ_Rule_TEMPLATE,$(call MAKE_CallForEach,MAKE_EncodePath,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET))))

endef


# Generate the Make code for the rule
# $1 Pre-MAKE_EncodePath()d target list
define PROJ_Rule_TEMPLATE
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(1): $(v) := $$($(call PROJ_PersistentNameUnsafe,$(v),$(PROJ_dir_asword)))#)

$(if $(RULE_PHONY), \
$(foreach t,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)), \
$(MAKE_CHAR_NEWLINE).PHONY: $(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(t))) \
) \
)

$(if $(RULE_REQDBYS)$(RULE_REQDBY), \
$(foreach r,$(RULE_REQDBYS) $(call MAKE_EncodeWord,$(RULE_REQDBY)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(r)))) \
\$(MAKE_CHAR_NEWLINE): \
$(foreach t,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(t)))) \
)

$(foreach t,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(t)))) \
\$(MAKE_CHAR_NEWLINE): \
\
$(foreach r,$(RULE_REQS) $(call MAKE_EncodeWord,$(RULE_REQ)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(r)))) \
\
$(if $(RULE_OREQS)$(RULE_OREQ),\$(MAKE_CHAR_NEWLINE)| $(foreach r,$(RULE_OREQS) $(call MAKE_EncodeWord,$(RULE_OREQ)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(r)))))

	$$(SHELL_TARGETHEADING)
ifneq ($$(MAKERY_DEBUG),)
	@echo $$(call SHELL_Escape,[newer prerequisites: $$(?)])
endif
	
$(RULE_COMMANDS)

$(foreach varname,$(filter RULE_%,$(.VARIABLES)),$(MAKE_CHAR_NEWLINE)$(varname) :=#)

endef



# ------------------------------------------------------------------------------
# Global Targets
# ------------------------------------------------------------------------------

# The global default target
.PHONY: default
default:
	$(SHELL_TARGETHEADING)


# Don't do anything
.PHONY: null
null:
	$(SHELL_TARGETHEADING)

