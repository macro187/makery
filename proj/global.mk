# ------------------------------------------------------------------------------
# Copyright (c) 2007, 2008, 2009
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


# ------------------------------------------------------------------------------
# Project paths and location
# ------------------------------------------------------------------------------

PROJ_PATHS := $(PROJ_PATHS)
PROJ_PATHS_DESC := Paths that PROJ_Locate() searches for projects in (list)
MAKERY_GLOBALS += PROJ_PATHS


# Locate a project in PROJ_PATHS
#
# Params
# $1 Directory name of project to find
#
# Errors
# TODO If the project can't be found
PROJ_Locate = \
$(MAKERY_Trace1)$(if $(call MAKE_DecodeWord,$(firstword $(foreach d,$(PROJ_PATHS),$(call MAKE_EncodeWord,$(call SHELL_DirToAbs,$(call MAKE_DecodeWord,$(d)/$(1))))))),$(call MAKE_DecodeWord,$(firstword $(foreach d,$(PROJ_PATHS),$(call MAKE_EncodeWord,$(call SHELL_DirToAbs,$(call MAKE_DecodeWord,$(d))/$(1)))))),$(error Can not find project '$(1)' in PROJ_PATHS))



# ------------------------------------------------------------------------------
# List of Projects Processed
# ------------------------------------------------------------------------------

PROJ_PROJECTS := $(PROJ_PROJECTS)



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
PROJ_vars += $(1)
ifeq ($$($(1)),)
$(1) = $$($(1)_DEFAULT)
endif
endef


# ------------------------------------------------------------------------------
# Declare a target-time project variable
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

PROJ_DeclareTargetVar = \
$(eval $(call PROJ_DeclareTargetVar_TEMPLATE,$(1)))

define PROJ_DeclareTargetVar_TEMPLATE
PROJ_targetvars += $(1)
ifeq ($$($(1)),)
$(1) = $(value $(1)_DEFAULT)
endif
PROJ_vars += $(1)_def
$(1)_def = $$(value $(1))
endef



# ------------------------------------------------------------------------------
# Persistent (stashed) variables
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
# (internal) Variable Management
# ------------------------------------------------------------------------------

# Flatten project variables down to immediate variables
PROJ_FlattenVars = \
$(MAKERY_TraceBegin)$(eval $(call PROJ_FlattenVars_TEMPLATE))$(MAKERY_TraceEnd)

define \
PROJ_FlattenVars_TEMPLATE
$$(call MAKERY_Debug,Begin PROJ_FlattenVars_TEMPLATE)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) := $$($(v))#)
$$(call MAKERY_Debug,End PROJ_FlattenVars_TEMPLATE)
endef


# Stash project variables
PROJ_StashVars = \
$(MAKERY_Trace)$(eval $(call PROJ_StashVars_TEMPLATE))

define \
PROJ_StashVars_TEMPLATE
$$(call MAKERY_Debug,Begin PROJ_StashVars_TEMPLATE)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(call PROJ_PersistentNameUnsafe,$(v),$(PROJ_dir_asword)) := $$($(v))#)
$$(call MAKERY_Debug,End PROJ_StashVars_TEMPLATE)
endef


# Retrieve vars
PROJ_RetrieveVars = \
$(MAKERY_Trace)$(eval $(call PROJ_RetrieveVars_TEMPLATE))

define \
PROJ_RetrieveVars_TEMPLATE
$$(call MAKERY_Debug,Begin PROJ_RetrieveVars_TEMPLATE)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) := $$($(call PROJ_PersistentNameUnsafe,$(v),$(PROJ_dir_asword)))#)
$$(call MAKERY_Debug,End PROJ_RetrieveVars_TEMPLATE)
endef


# Clear project variables
PROJ_ClearVars = \
$(MAKERY_TraceBegin)$(eval $(PROJ_ClearVars_TEMPLATE))$(MAKERY_TraceEnd)

define \
PROJ_ClearVars_TEMPLATE
$$(call MAKERY_Debug,Begin PROJ_ClearVars_TEMPLATE)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) =#$(MAKE_CHAR_NEWLINE)$(v)_DEFAULT =#)
$(foreach v,$(PROJ_targetvars),$(MAKE_CHAR_NEWLINE)$(v) =#)
$$(call MAKERY_Debug,End PROJ_ClearVars_TEMPLATE)
endef



# ------------------------------------------------------------------------------
# (internal) Required Projects
# ------------------------------------------------------------------------------

# Recursively process required projects
#
# Even though there are separate functions for each step, we have to do
# everything in one chunk otherwise we lose the required variables before we
# finish!
PROJ_ProcessRequired = \
$(MAKERY_TraceBegin)$(eval $(PROJ_TEMPLATE_PROCESSREQUIRED))$(MAKERY_TraceEnd)

define \
PROJ_TEMPLATE_PROCESSREQUIRED
$$(call MAKERY_Debug,Begin PROJ_TEMPLATE_PROCESSREQUIRED)
$(call PROJ_StashVars_TEMPLATE)
$(call PROJ_ClearVars_TEMPLATE)
$(foreach p,$(PROJ_required),$(call PROJ_IncludeRequired_TEMPLATE,$(call MAKE_DecodeWord,$(p))))
$(call PROJ_RetrieveVars_TEMPLATE)
$$(call MAKERY_Debug,End PROJ_TEMPLATE_PROCESSREQUIRED)
endef


# Pull in another project
#
# Params
# $1 Project dir (relative to current project's dir)
PROJ_IncludeRequired = \
$(MAKERY_Trace1)$(eval $(call PROJ_IncludeRequired_TEMPLATE,$(1)))

define \
PROJ_IncludeRequired_TEMPLATE
$$(call MAKERY_Debug,Begin PROJ_IncludeRequired_TEMPLATE)
PROJ_dir := $(call PROJ_LocateFromHere,$(1))
ifeq ($$(PROJ_dir),)
$$(error Required project '$(1)' does not exist)
endif
ifeq ($$(filter $$(call MAKE_EncodeWord,$$(PROJ_dir)),$$(PROJ_PROJECTS)),)
include $$(call MAKE_EncodePath,$$(PROJ_dir))/Makefile
else
$$(call MAKERY_Debug,Refraining from re-processing '$$(PROJ_dir)')
$$(call MAKERY_Debug,End PROJ_IncludeRequired_TEMPLATE)
endif

endef


# Locate another project relative to the current project
#
# Params
# $1 The project's dir, relative to the current project's dir
#
# Returns
# The absolute path of the requested project, or blank if it doesn't exist
PROJ_LocateFromHere = \
$(MAKERY_Trace1)$(call SHELL_RelDirToAbs,$(1),$(PROJ_dir))



# ------------------------------------------------------------------------------
# Variable Validation
# ------------------------------------------------------------------------------

# Run validations
PROJ_Validate = \
$(MAKERY_Trace)$(foreach var,$(PROJ_vars),$(foreach val,$($(var)_VALIDATE),$(call PROJ_DeclValidate,$(var),$(subst |, ,$(val)))))\
$(eval $(PROJ_Validate_TEMPLATE))

define PROJ_Validate_TEMPLATE
$(foreach module,$(MODULES_proj),$(MAKE_CHAR_NEWLINE)-include $(call MAKE_EncodePath,$(call MODULES_Locate,$(module))/validate.mk))
endef

# $1 Variable name
# $2 Pre-split validation declaration item
PROJ_DeclValidate = \
$(call PROJ_Validator$(firstword $(2)),$(1),$(wordlist 2,99,$(2)))


# Throw a validation error
# $1 Variable name
# $2 Reason
PROJ_ValidationError = \
$(error $(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_NEWLINE)$(2)$(MAKE_CHAR_NEWLINE)Project: $(PROJ_dir)$(MAKE_CHAR_NEWLINE)Variable: $(1)$(MAKE_CHAR_NEWLINE)Value: '$($(1))'$(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_NEWLINE))


# Throw a validation error if a condition is true
# $1 Condition
# $2 Variable name
# $3 Reason
PROJ_ValidationErrorIf = \
$(if $(1),$(call PROJ_ValidationError,$(2),$(3)))


# Declarative Validation
#
# Example:
#   MYMODULE_myvar_VALIDATE = Required Between|1|10
#
# Declares that MYMODULES_myvar is required and must be between 1 and 10.
# Each item in the *_VALIDATE list is the last part of the validation function
# name, eg. PROJ_ValidateRequired and PROJ_ValidateBetween, optionally
# followed by a pipe-separated list of parameters to the validation function.
#
# Validators must adhere to a pattern so that declarative validation works:
# PROJ_Validate<name>
# $1 is always the variable name
# $2 is always the parameter list

# Required
PROJ_ValidatorRequired = \
$(call PROJ_ValidationErrorIf,$(call not,$($(1))),$(1),A value is required)

# Min|<mininclusive>
PROJ_ValidatorMin = \
$(if $($(1)),$(call PROJ_ValidationErrorIf,$(call lt,$($(1)),$(word 1,$(2))),$(1),Minimum value is $(word 1,$(2))))

# Max|<maxinclusive>
PROJ_ValidatorMax = \
$(if $($(1)),$(call PROJ_ValidationErrorIf,$(call gt,$($(1)),$(word 1,$(2))),$(1),Maximum value is $(word 1,$(2))))

# Between|<mininclusive>|<maxinclusive>
PROJ_ValidatorBetween = \
$(if $($(1)),$(call PROJ_ValidationErrorIf,$(call lt,$($(1)),$(word 1,$(2)))$(call gt,$($(1)),$(word 2,$(2))),$(1),Must be between $(word 1,$(2)) and $(word 2,$(2))))



# ------------------------------------------------------------------------------
# Template for including rules.mk for modules involved in the current
# ------------------------------------------------------------------------------

PROJ_GenerateRules = \
$(eval $(PROJ_GenerateRules_TEMPLATE))

define \
PROJ_GenerateRules_TEMPLATE
ALLTARGETS :=
$(foreach module,$(MODULES_proj),$(MAKE_CHAR_NEWLINE)-include $(call MAKE_EncodePath,$(call MODULES_Locate,$(module))/rules.mk))
$$(call PROJ_TargetVars,$$(ALLTARGETS))
ALLTARGETS :=
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
#
# RULE_COMMANDS
# ------------------------------------------------------------------------------


PROJ_RuleNewLine = \
$(MAKE_CHAR_BS)$(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_TAB)$(1)


# Generates a project-specific rule given parameters specified in RULE_*
# variables
PROJ_Rule = \
$(MAKERY_TraceBegin) \
$(if $(RULE_TARGET)$(RULE_TARGETS), \
$(call MAKERY_Debug,Rule$(MAKE_CHAR_NEWLINE)$(PROJ_Rule_DUMP)) \
$(eval $(call PROJ_Rule_TEMPLATE,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),$(call MAKE_CallForEach,MAKE_EncodePath,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET))))) \
)$(MAKERY_TraceEnd)



# Generate the Make code for the rule
# $1 All targets
# $2 All targets, MAKE_EncodePath()ed
define PROJ_Rule_TEMPLATE
ALLTARGETS += $$(RULE_TARGETS) $$(call MAKE_EncodeWord,$$(RULE_TARGET))

$(if $(RULE_PHONY),.PHONY: $(2))

$(if $(RULE_REQDBYS)$(RULE_REQDBY), \
$(foreach r,$(RULE_REQDBYS) $(call MAKE_EncodeWord,$(RULE_REQDBY)),$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(r))): $(2)) \
)

$(2): \
$(foreach r,$(RULE_REQS) $(call MAKE_EncodeWord,$(RULE_REQ)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(r)))) \
\
$(if $(RULE_OREQS)$(RULE_OREQ),\$(MAKE_CHAR_NEWLINE)| $(foreach r,$(RULE_OREQS) $(call MAKE_EncodeWord,$(RULE_OREQ)),\$(MAKE_CHAR_NEWLINE)$(call MAKE_EncodePath,$(call MAKE_DecodeWord,$(r)))))

	$$(SHELL_TARGETHEADING)
ifneq ($$(MAKERY_DEBUG),)
	@echo $$(call SHELL_Escape,[newer prerequisites: $$(?)])
endif
	
$(RULE_COMMANDS)

$$(call MAKE_ClearVarsWithPrefix,RULE_)
endef


# Generate a dump of information about the rule
ifneq ($(MAKERY_DEBUG),)
define PROJ_Rule_DUMP
Targets:$(if $(RULE_TARGETS)(RULE_TARGET),$(foreach t,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(t))),$(MAKE_CHAR_NEWLINE)(none))

Phony:
$(if $(RULE_PHONY),yes,no)

Prerequisites:$(if $(RULE_REQS)$(RULE_REQ),$(foreach p,$(RULE_REQS) $(call MAKE_EncodeWord,$(RULE_REQ)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(p))),$(MAKE_CHAR_NEWLINE)(none))

Order-only Prerequisites:$(if $(RULE_OREQS)$(RULE_OREQ),$(foreach p,$(RULE_OREQS) $(call MAKE_EncodeWord,$(RULE_OREQ)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(p))),$(MAKE_CHAR_NEWLINE)(none))

Prerequisite of:$(if $(RULE_REQDBYS)$(RULE_REQDBY),$(foreach r,$(RULE_REQDBYS) $(call MAKE_EncodeWord,$(RULE_REQDBY)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(r))),$(MAKE_CHAR_NEWLINE)(none))

Commands:
$(if $(RULE_COMMANDS),$(RULE_COMMANDS),(none))

endef
else
define PROJ_Rule_DUMP
endef
endif



# Generate target-specific versions of project variables
#
# Params
# $1 List of targets
PROJ_TargetVars = \
$(MAKERY_Trace1)$(eval $(call PROJ_TargetVars_TEMPLATE,$(call MAKE_CallForEach,MAKE_EncodePath,$(1))))
#$(warning $(call PROJ_TargetVars_TEMPLATE,$(call MAKE_CallForEach,MAKE_EncodePath,$(1))))\

# $1 PathEncode()ed list of targets
define \
PROJ_TargetVars_TEMPLATE
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(1): $(v) := $$($(call PROJ_PersistentNameUnsafe,$(v),$(PROJ_dir_asword)))#)
$(foreach v,$(PROJ_targetvars),$(MAKE_CHAR_NEWLINE)$(1): $(v) = $($(v)_def)#)
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

