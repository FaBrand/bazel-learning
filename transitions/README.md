# Scenario

A source file is compiled with different flags.

The flags are set via transitions.

One configuration is buildable and the other is not aka,

For one configuration (variant_a) the included header can be found.
For one configuration (variant_b) the included header can not be found.

The header is included only if a define `-DVARIANTA/B` is set.

# Error
If a rule adds two binaries with different transitions, one is built with the wrong set of flags.
This is expressed by the compilation failing because of the missing header.
