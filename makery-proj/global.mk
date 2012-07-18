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


# ------------------------------------------------------------------------------
# Locations
# ------------------------------------------------------------------------------

# Locate a project in $(MAKERYPATH)
#
# $1 - Directory name of project to find
#
# Error if the project cannot be found under one of the directories in PROJ_PATH
#
PROJ_Locate = \
$(MAKERY_TRACEBEGIN1)$(if $(call PROJ_Locate_GetCache,$(1)),$(call PROJ_Locate_GetCache,$(1)),$(call PROJ_Locate_SetCache,$(1),$(call PROJ_Locate_Check,$(1),$(call PROJ_Locate_Internal,$(1)))))$(MAKERY_TRACEEND1)

PROJ_Locate_Check = \
$(if $(2),$(2),$(error Can not find project '$(1)' in MAKERYPATH))

PROJ_Locate_Internal = \
$(MAKERY_TRACEBEGIN1)$(call MAKE_DecodeWord,$(firstword $(foreach d,$(MAKERYPATH),$(call MAKE_EncodeWord,$(call SYSTEM_DirToAbs,$(call MAKE_DecodeWord,$(d))/$(1))))))$(MAKERY_TRACEEND1)


# Get the cached location of a project
#
# $1 - Project name
#
# Returns the cached location, or nothing if not cached
#
PROJ_Locate_GetCache = \
$(PROJ_LOCATION_$(call MAKE_EncodeWord,$(1)))


# Cache the location of a project
#
# $1 - Project name
# $2 - Project location
#
# Returns the location
#
PROJ_Locate_SetCache = \
$(eval $(call PROJ_SaveLocation_TEMPLATE,$(1),$(2)))$(2)

# $1 - Project name
# $2 - Project location
#
define PROJ_SaveLocation_TEMPLATE
PROJ_LOCATION_$(call MAKE_EncodeWord,$(1)) := $(2)
endef


# List of locations of processed projects
#
PROJ_PROJECTS := $(PROJ_PROJECTS)



# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

# Declare a project variable
#
# $1 - Variable name
#
# This function is valid in modules' project.mk.
#
# Usage:
#
#   $(call PROJ_DeclareVar,<MODULE>_<variable>)
#   <MODULE>_<variable>_DESC ?= (optional description)
#   <MODULE>_<variable>_DEFAULT = (optional default value)
#   <MODULE>_<variable>_OPTIONS = (optional list of options)
#   <MODULE>_<variable>_MASK = (options to mask)
#   <MODULE>_<variable>_AVAIL = (autogenerated reaonly list of masked options)
#
PROJ_DeclareVar = \
$(eval $(call PROJ_DeclareVar_TEMPLATE,$(1)))

define PROJ_DeclareVar_TEMPLATE
PROJ_vars += $(1)

$(1)_AVAIL = $$(filter-out $$($(1)_MASK),$$($(1)_OPTIONS))

ifeq ($$(strip $$(value $(1)_DEFAULT)),)
$(1)_DEFAULT = $$(if $$(if $$($(call uc,$(1))),$$(filter $$($(call uc,$(1))),$$($(1)_AVAIL))),$$($(call uc,$(1))),$$(firstword $$($(1)_AVAIL)))
endif

ifeq ($$(strip $$($(1))),)
$(1) = $$($(1)_DEFAULT)
endif
endef


# Declare a target-time project variable
#
# $1 - Variable name
#
# Target variables are not expanded during the preprocessing stage.  Instead, a
# regular project variable (with the same name plus a '_def' suffix) stores the
# unexpanded definition, which is used to arrange for deferred expansion later
# at rules-execution time.
#
# Because of this deferred expansion, target variables can reference:
#
# - Global variables
# - Project variables from this or any other project
# - Target variables from this or any other project
#
# Note this does not include temporary variables available during the
# preprocessing stage (eg. *_DEFAULT variables, etc.)
#
# This function is only valid in a module's project.mk
#
# Usage:
#
#   $(call PROJ_DeclareVar,<MODULE>_<variable>)
#   <MODULE>_<variable>_DESC ?= (optional description)
#
PROJ_DeclareTargetVar = \
$(eval $(call PROJ_DeclareTargetVar_TEMPLATE,$(1)))

define PROJ_DeclareTargetVar_TEMPLATE
PROJ_targetvars += $(1)
PROJ_vars += $(1)_def
$(1)_def = $$(value $(1))
endef


# Compute the persistent name of a variable for a particular project
#
# $1 - Variable name
# $2 - Project name
#
PROJ_PersistentVarName = \
PROJ_VAR__$(2)__$(1)


# Get the value of a specified variable from a specified project
#
# $1 - Variable name
# $2 - Project name
#
# Usable in rules or target variables
#
PROJ_GetVar = \
$($(call PROJ_PersistentVarName,$(1),$(2)))


# Debug print messages displaying names, values, and other information about
# all project variables
#
PROJ_DebugPrintVarInfo =
ifdef MAKERYDEBUG
PROJ_DebugPrintVarInfo = $(info [debug] Project Variables:)$(foreach v,$(PROJ_vars),$(eval $(call PROJ_DebugPrintVarInfo_TEMPLATE,$(v))))
endif

define PROJ_DebugPrintVarInfo_TEMPLATE
$$(info $(1))
ifneq ($$($(1)_DESC),)
$$(info $$(MAKE_CHAR_SPACE) Description)
$$(info $$(MAKE_CHAR_SPACE)   $$($(1)_DESC))
endif
ifneq ($$($(1)_OPTIONS),)
$$(info $$(MAKE_CHAR_SPACE) Options)
$$(info $$(MAKE_CHAR_SPACE)   $$($(1)_OPTIONS))
$$(info $$(MAKE_CHAR_SPACE) Available Options)
$$(info $$(MAKE_CHAR_SPACE)   $$($(1)_AVAIL))
endif
$$(info $$(MAKE_CHAR_SPACE) Value)
$$(info $$(MAKE_CHAR_SPACE)   '$$($(1))')
endef


# Get the value of a single-value variable from a list of projects
#
# $1 - Variable name
# $2 - List of project names
#
PROJ_GetVarMulti = \
$(MAKERY_TRACEBEGIN2) \
$(foreach p,$(2),$(call MAKE_EncodeWord,$(call PROJ_GetVar,$(1),$(p)))) \
$(MAKERY_TRACEEND2)


# Get the values of a single-value variable from all projects listed in a
# second variable, recursively
#
# $1 - Variable name
# $2 - Name of variable containing list of project names
# $3 - Project name (optional, defaults to current)
# $4 - List of names of projects already visited (internal, optional, to handle
#      circular references)
#
# Usable in rules or target variables.
#
# Values are sorted with duplicates removed.
#
PROJ_GetVarRecursive = \
$(MAKERY_TRACEBEGIN3) \
$(sort \
$(foreach p,$(call PROJ_GetVar,$(if $(2),$(2),PROJ_required),$(if $(3),$(3),$(PROJ_name))), \
$(if $(filter $(p),$(if $(3),$(3),$(PROJ_name)) $(4)),, \
$(call MAKE_EncodeWord,$(call PROJ_GetVar,$(1),$(p))) \
$(call PROJ_GetVarRecursive,$(1),$(2),$(p),$(4) $(if $(3),$(3),$(PROJ_name)) $(p)) \
) \
) \
) \
$(MAKERY_TRACEEND3)


# Get the values of a list variable from all projects listed in a
# second variable, recursively
#
# (See PROJ_GetVarRecursive )
#
PROJ_GetMultiRecursive = \
$(MAKERY_TRACEBEGIN3) \
$(sort \
$(foreach p,$(call PROJ_GetVar,$(if $(2),$(2),PROJ_required),$(if $(3),$(3),$(PROJ_name))), \
$(if $(filter $(p),$(if $(3),$(3),$(PROJ_name)) $(4)),, \
$(call PROJ_GetVar,$(1),$(p)) \
$(call PROJ_GetMultiRecursive,$(1),$(2),$(p),$(4) $(if $(3),$(3),$(PROJ_name)) $(p)) \
) \
) \
) \
$(MAKERY_TRACEEND3)


# (internal) Flatten project variables down to immediate variables
#
PROJ_FlattenVars = \
$(MAKERY_TRACEBEGIN)$(eval $(call PROJ_FlattenVars_TEMPLATE))$(MAKERY_TRACEEND)

define PROJ_FlattenVars_TEMPLATE
$$(MAKERY_TRACEBEGIN)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) := $$($(v))#)
$$(MAKERY_TRACEEND)
endef


# (internal) Stash project variables
#
PROJ_StashVars = \
$(MAKERY_TRACE)$(eval $(call PROJ_StashVars_TEMPLATE))

define PROJ_StashVars_TEMPLATE
$$(MAKERY_TRACEBEGIN)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(call PROJ_PersistentVarName,$(v),$(PROJ_name)) := $$($(v))#)
$$(MAKERY_TRACEEND)
endef


# (internal) Retrieve vars
#
PROJ_RetrieveVars = \
$(MAKERY_TRACEBEGIN)$(eval $(call PROJ_RetrieveVars_TEMPLATE))$(MAKERY_TRACEEND)

define PROJ_RetrieveVars_TEMPLATE
$$(MAKERY_TRACEBEGIN)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) := $$($(call PROJ_PersistentVarName,$(v),$(PROJ_name)))#)
$$(MAKERY_TRACEEND)
endef


# (internal) Clear project variables
#
PROJ_ClearVars = \
$(MAKERY_TRACEBEGIN)$(eval $(PROJ_ClearVars_TEMPLATE))$(MAKERY_TRACEEND)

define PROJ_ClearVars_TEMPLATE
$$(MAKERY_TRACEBEGIN)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v) =#)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v)_DESC := $(v)_DESC#)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v)_DEFAULT =#)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v)_VALIDATE =#)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v)_OPTIONS =#)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v)_AVAIL =#)
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(v)_MASK =#)
$(foreach v,$(PROJ_targetvars),$(MAKE_CHAR_NEWLINE)$(v) =#)
$$(MAKERY_TRACEEND)
endef


# (internal) Validate variables
#
PROJ_Validate = \
$(MAKERY_TRACEBEGIN)$(foreach var,$(PROJ_vars),$(foreach val,$($(var)_VALIDATE),$(call PROJ_DeclValidate,$(var),$(subst |, ,$(val)))))$(MAKERY_TRACEEND)


# (internal) Validate a variable according to $(<MODULE>_<var>_VALIDATE)
#
# $1 - Variable name
# $2 - Pre-split validation declaration item
#
PROJ_DeclValidate = \
$(MAKERY_TRACEBEGIN2)$(call PROJ_Validator$(firstword $(2)),$(1),$(wordlist 2,99,$(2)))$(MAKERY_TRACEEND2)


# (internal) Throw a validation error
#
# $1 - Variable name
# $2 - Reason
#
PROJ_ValidationError = \
$(MAKERY_TRACEBEGIN2)$(error $(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_NEWLINE)$(2)$(MAKE_CHAR_NEWLINE)Project: $(PROJ_name)$(MAKE_CHAR_NEWLINE)Variable: $(1)$(MAKE_CHAR_NEWLINE)Value: '$($(1))'$(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_NEWLINE))$(MAKERY_TRACEEND2)


# (internal) Throw a validation error if a condition is true
#
# $1 - Condition
# $2 - Variable name
# $3 - Reason
#
PROJ_ValidationErrorIf = \
$(MAKERY_TRACEBEGIN3)$(if $(1),$(call PROJ_ValidationError,$(2),$(3)))$(MAKERY_TRACEEND3)


# Validators
#
# Example:
#   MYMODULE_myvar_VALIDATE = Required Between|1|10
#
# Declares that MYMODULES_myvar is required and must be between 1 and 10.
# Each item in the *_VALIDATE list is the last part of the validation function
# name, eg. PROJ_ValidateRequired and PROJ_ValidateBetween, optionally
# followed by a pipe-separated list of parameters to the validation function.
#
# Validators must adhere to the following pattern:
#
#     PROJ_Validate<name>
#
#     $1 - Variable name
#     $2 - List of arguments

# Required
#
PROJ_ValidatorRequired = \
$(MAKERY_TRACEBEGIN2)$(call PROJ_ValidationErrorIf,$(call not,$($(1))),$(1),A value is required)$(MAKERY_TRACEEND2)

# Min|<mininclusive>
#
PROJ_ValidatorMin = \
$(if $($(1)),$(call PROJ_ValidationErrorIf,$(call lt,$($(1)),$(word 1,$(2))),$(1),Minimum value is $(word 1,$(2))))

# Max|<maxinclusive>
#
PROJ_ValidatorMax = \
$(if $($(1)),$(call PROJ_ValidationErrorIf,$(call gt,$($(1)),$(word 1,$(2))),$(1),Maximum value is $(word 1,$(2))))

# Between|<mininclusive>|<maxinclusive>
#
PROJ_ValidatorBetween = \
$(if $($(1)),$(call PROJ_ValidationErrorIf,$(call lt,$($(1)),$(word 1,$(2)))$(call gt,$($(1)),$(word 2,$(2))),$(1),Must be between $(word 1,$(2)) and $(word 2,$(2))))



# ------------------------------------------------------------------------------
# (internal) Required Projects
# ------------------------------------------------------------------------------

# Recursively process required projects
#
# Even though there are separate functions for each step, we have to do
# everything in one chunk otherwise we lose the required variables before we
# finish!
#
PROJ_ProcessRequired = \
$(MAKERY_TRACEBEGIN)$(eval $(PROJ_TEMPLATE_PROCESSREQUIRED))$(MAKERY_TRACEEND)

define PROJ_TEMPLATE_PROCESSREQUIRED
$$(MAKERY_TRACEBEGIN)
$(call PROJ_StashVars_TEMPLATE)
$(call PROJ_ClearVars_TEMPLATE)
$(foreach p,$(PROJ_required),$(call PROJ_IncludeRequired_TEMPLATE,$(p)))
$(call PROJ_RetrieveVars_TEMPLATE)
$$(MAKERY_TRACEEND)
endef


# Pull in another project
#
# $1 - Project name
#
PROJ_IncludeRequired = \
$(MAKERY_TRACE1)$(eval $(call PROJ_IncludeRequired_TEMPLATE,$(1)))

define PROJ_IncludeRequired_TEMPLATE
$$(MAKERY_TRACEBEGIN1)
PROJ_dir := $(call PROJ_Locate,$(1))
ifeq ($$(filter $$(call MAKE_EncodeWord,$$(PROJ_dir)),$$(PROJ_PROJECTS)),)
include $$(call MAKE_EncodePath,$$(PROJ_dir))/Makefile
else
$$(call MAKERY_Debug,Refraining from re-processing '$$(PROJ_dir)')
$$(MAKERY_TRACEEND1)
endif

endef



# ------------------------------------------------------------------------------
# Rules
#
# Example (TODO)
#     RULE_TARGET
#     RULE_TARGETS
#     RULE_PHONY
#     RULE_REQ
#     RULE_REQS
#     RULE_OREQ
#     RULE_OREQS
#     RULE_REQDBY
#     RULE_REQDBYS
#
#     RULE_COMMANDS
# ------------------------------------------------------------------------------


# TODO
#
PROJ_RuleNewLine = \
$(MAKE_CHAR_BS)$(MAKE_CHAR_NEWLINE)$(MAKE_CHAR_TAB)$(1)


# Generates a project-specific rule given parameters specified in RULE_*
# variables
#
PROJ_Rule = \
$(MAKERY_TRACEBEGIN) \
$(if $(RULE_TARGET)$(RULE_TARGETS), \
$(call MAKERY_Debug,Rule$(MAKE_CHAR_NEWLINE)$(PROJ_Rule_DUMP)) \
$(eval $(call PROJ_Rule_TEMPLATE,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),$(call MAKE_CallForEach,MAKE_EncodePath,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET))))) \
)$(MAKERY_TRACEEND)


# (internal) Generate the Make code for the rule
#
# $1 - All targets
# $2 - All targets, MAKE_EncodePath()ed
#
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

	$$(MAKERY_TARGETHEADING)

$(RULE_COMMANDS)

$$(call MAKE_ClearVarsWithPrefix,RULE_)
endef


# (internal) Generate a dump of information about the rule
#
ifdef MAKERYDEBUG
define PROJ_Rule_DUMP
--------------------------------------------------------------------------------
Targets:$(if $(RULE_TARGETS)(RULE_TARGET),$(foreach t,$(RULE_TARGETS) $(call MAKE_EncodeWord,$(RULE_TARGET)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(t))),$(MAKE_CHAR_NEWLINE)(none))

Phony:
$(if $(RULE_PHONY),yes,no)

Prerequisites:$(if $(RULE_REQS)$(RULE_REQ),$(foreach p,$(RULE_REQS) $(call MAKE_EncodeWord,$(RULE_REQ)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(p))),$(MAKE_CHAR_NEWLINE)(none))

Order-only Prerequisites:$(if $(RULE_OREQS)$(RULE_OREQ),$(foreach p,$(RULE_OREQS) $(call MAKE_EncodeWord,$(RULE_OREQ)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(p))),$(MAKE_CHAR_NEWLINE)(none))

Prerequisite of:$(if $(RULE_REQDBYS)$(RULE_REQDBY),$(foreach r,$(RULE_REQDBYS) $(call MAKE_EncodeWord,$(RULE_REQDBY)),$(MAKE_CHAR_NEWLINE)$(call MAKE_DecodeWord,$(r))),$(MAKE_CHAR_NEWLINE)(none))

Commands:
$(if $(RULE_COMMANDS),$(RULE_COMMANDS),(none))
--------------------------------------------------------------------------------

endef
else
define PROJ_Rule_DUMP
endef
endif



# (internal) Generate target-specific versions of project variables
#
# $1 - List of targets
#
PROJ_TargetVars = \
$(MAKERY_TRACEBEGIN1)$(eval $(call PROJ_TargetVars_TEMPLATE,$(call MAKE_CallForEach,MAKE_EncodePath,$(1))))$(MAKERY_TRACEEND1)

# $1 PathEncode()ed list of targets
#
define PROJ_TargetVars_TEMPLATE
$(foreach v,$(PROJ_vars),$(MAKE_CHAR_NEWLINE)$(1): $(v) := $$($(call PROJ_PersistentVarName,$(v),$(PROJ_name)))#)
$(foreach v,$(PROJ_targetvars),$(MAKE_CHAR_NEWLINE)$(1): $(v) = $($(v)_def)#)
endef


# (internal) Template for including rules.mk for modules involved in the
# current project
#
PROJ_GenerateRules = \
$(eval $(PROJ_GenerateRules_TEMPLATE))

define PROJ_GenerateRules_TEMPLATE
ALLTARGETS :=
$(foreach module,$(MODULES_proj),$(MAKE_CHAR_NEWLINE)-include $(call MAKE_EncodePath,$(call MODULES_Locate,$(module))/rules.mk))
$$(call PROJ_TargetVars,$$(ALLTARGETS))
ALLTARGETS :=
endef



# ------------------------------------------------------------------------------
# Global Targets
# ------------------------------------------------------------------------------

# The global default target (which currently does nothing)
#
.PHONY: default
default:
	$(MAKERY_TARGETHEADING)


# Don't do anything (which explicitly does nothing)
#
.PHONY: null
null:
	$(MAKERY_TARGETHEADING)

