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


NUGET_URL_DESC ?= \
URL to download nuget.exe
MAKERY_GLOBALS += NUGET_URL
NUGET_URL := http://www.nuget.org/nuget.exe


NUGET_SHARED_DESC ?= \
Shared, cached copy of nuget.exe (read-only).  NUGET_dotfile must be built.
MAKERY_GLOBALS += NUGET_SHARED
NUGET_SHARED := $(TEMPDIR_TEMPDIR)/nuget.exe


NUGET_RULECREATED_DESC ?= \
Has a rule for NUGET_SHARED been created yet?
MAKERY_GLOBALS += NUGET_RULECREATED

