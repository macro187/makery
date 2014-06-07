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


HTDOCS_RUN_module_DESC ?= \
Web server module to use
$(call PROJ_DeclareVar,HTDOCS_RUN_module)
HTDOCS_RUN_module_OPTIONS = $(HTDOCS_RUN_MODULES)
HTDOCS_RUN_module_VALIDATE = Required


HTDOCS_RUN_port_DESC ?= \
Port to serve the project from
$(call PROJ_DeclareVar,HTDOCS_RUN_port)
HTDOCS_RUN_port_DEFAULT = 8080


HTDOCS_RUN_browse_DESC ?= \
(read-only) Phony target that opens a web browser to the project
$(call PROJ_DeclareVar,HTDOCS_RUN_browse)
HTDOCS_RUN_browse = $(OUT_dir)/htdocs-run-browse


# Hook up to run
#
RUN_reqs += $(call MAKE_EncodeWord,$(HTDOCS_dotfile))
RUN_reqs += $(call MAKE_EncodeWord,$(HTDOCS_RUN_browse))
RUN_run = $(HTDOCS_RUN_$(call uc,$(HTDOCS_RUN_module))_run)

