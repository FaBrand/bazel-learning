#include "lib/library_includer.h"

// other includes

#include "lib/library_includes.h"
#include "lib/library_prefix.h"
#include "lib/library_private.h"

// These two headers should not be found since they are supposedly private headers of library_private
#include "private_header.h"
#include "sub/sub.h"

LibraryIncluder::LibraryIncluder() = default;
