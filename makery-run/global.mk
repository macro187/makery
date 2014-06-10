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


# Convert a path fragment for use as a command-line argument to the program
#
# $1 - Path
# $2 - The runnable program's name (optional, defaults to current)
#
RUN_ArgPath = \
$(if $(call PROJ_GetVar,RUN_argpathfunc,$(if $(2),$(2),$(PROJ_name))),,$(error No RUN_argpathfunc for $(if $(2),$(2),$(PROJ_name)), perhaps its not runnable?))$(call $(call PROJ_GetVar,RUN_argpathfunc,$(if $(2),$(2),$(PROJ_name))),$(1))


# Convert and map a full path for use as a command-line argument to the program
#
# $1 - Path
# $2 - The runnable program's name (optional, defaults to current)
#
#
RUN_ArgPathAbs = \
$(if $(call PROJ_GetVar,RUN_argpathabsfunc,$(if $(2),$(2),$(PROJ_name))),,$(error No RUN_argpathabsfunc for $(if $(2),$(2),$(PROJ_name)), perhaps its not runnable?))$(call $(call PROJ_GetVar,RUN_argpathabsfunc,$(if $(2),$(2),$(PROJ_name))),$(1))


# Run the current project / all runnable projects
#
.PHONY: run runall
run runall:
	$(MAKERY_TARGETHEADING)

