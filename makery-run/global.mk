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
# Convert a path fragment for use as a command-line argument to the program
#
# $1 - Path
# $2 - The runnable program's PROJ_dir (optional, defaults to current)
# ------------------------------------------------------------------------------

RUN_ArgPath = \
$(if $(call PROJ_GetVar,RUN_argpathfunc,$(if $(2),$(2),$(PROJ_dir))),,$(error No RUN_argpathfunc for $(if $(2),$(2),$(PROJ_dir)), perhaps its not runnable?))$(call $(call PROJ_GetVar,RUN_argpathfunc,$(if $(2),$(2),$(PROJ_dir))),$(1))



# ------------------------------------------------------------------------------
# Convert and map a full path for use as a command-line argument to the program
#
# $1 - Path
# ------------------------------------------------------------------------------

RUN_ArgPathAbs = \
$(if $(call PROJ_GetVar,RUN_argpathabsfunc,$(if $(2),$(2),$(PROJ_dir))),,$(error No RUN_argpathabsfunc for $(if $(2),$(2),$(PROJ_dir)), perhaps its not runnable?))$(call $(call PROJ_GetVar,RUN_argpathabsfunc,$(if $(2),$(2),$(PROJ_dir))),$(1))



# ------------------------------------------------------------------------------
# Global targets
# ------------------------------------------------------------------------------

# Build a runnable version of the current project / all runnable projects
.PHONY: runnable runnableall
runnable runnableall:
	$(SYSTEM_SHELL_TARGETHEADING)

# Run the current project / all runnable projects
.PHONY: run runall
run runall:
	$(SYSTEM_SHELL_TARGETHEADING)


