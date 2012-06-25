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


TEST_project_DESC ?= \
The name of the runnable project that acts as a test for this one
$(call PROJ_DeclareVar,TEST_project)
TEST_project_DEFAULT = $(PROJ_name).Test


$(call PROJ_DeclareVar,TEST_projectdir)
TEST_projectdir_DESC ?= \
(internal) The dir of the runnable project that acts as a test for this one
TEST_projectdir = $(call PROJ_Locate,$(TEST_project))


$(call PROJ_DeclareVar,TEST_target)
TEST_target_DESC ?= The phony test target
TEST_target = $(PROJ_dir)/test


$(call PROJ_DeclareVar,TEST_reqs)
TEST_reqs_DESC ?= Prerequisites for testing (list)
TEST_reqs_DEFAULT = $(call MAKE_EncodeWord,$(TEST_projectdir)/run)


# Pull in the test project
PROJ_required += $(TEST_project)


# Hook "test" to "everything"
EVERYTHING_reqs += $(call MAKE_EncodeWord,$(TEST_target))

