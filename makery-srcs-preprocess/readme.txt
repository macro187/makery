makery-srcs-preprocess
======================

Implements a "pipeline" of modules that perform pre-processing on source code
files.



Preprocessor Modules
====================

Getting Information from Upstream Modules
-----------------------------------------

Modules use the SRCS_PREPROCESS_* functions to get information about the
upstream processing module.

`SRCS_PREPROCESS_GetUpstream()`

`SRCS_PREPROCESS_GetDir(<UpstreamModule>)`

`SRCS_PREPROCESS_GetFiles(<UpstreamModule>)`

`SRCS_PREPROCESS_GetPreqs(<UpstreamModule>)`


Providing Information to Downstream Modules
-------------------------------------------

Modules expose information in specially-named project variables for use by
downstream modules:

`<MODULE>_dir`, the root directory of output source code files

`<MODULE>_rel`, output source code files relative to `<MODULE>_dir`

`<MODULE>_preq`, prerequisites representing output source code files

