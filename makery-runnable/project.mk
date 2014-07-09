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

RUNNABLE_run_DESC := \
Pre-escaped command to run the project in-place
$(call PROJ_DeclareVar,RUNNABLE_run)


RUNNABLE_argpathfunc_DESC := \
Name of function to be called on all command-line arguments that are path \
fragments
$(call PROJ_DeclareVar,RUNNABLE_argpathfunc)
RUNNABLE_argpathfunc_DEFAULT = MAKE_Identity


RUNNABLE_argpathabsfunc_DESC := \
Name of function to be called on all command-line arguments that are full paths
$(call PROJ_DeclareVar,RUNNABLE_argpathabsfunc)
RUNNABLE_argpathabsfunc_DEFAULT = MAKE_Identity

