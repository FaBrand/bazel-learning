package(default_visibility = ['//visibility:public'])

filegroup( name="empty" )
filegroup(
    name="all",
    srcs = [
        "emcc.sh",
        "@emscripten_toolchain//:all",
        "@emscripten_clang//:all",
        ":emscripten_cache_content",
    ],

)

filegroup(
    name = "emscripten_cache_content",
    srcs = glob(["emscripten_cache/**/*"]),
)

cc_toolchain(
    name = "asmjs_toolchain",
    cpu = "asmjs",
    all_files = ":all",
    compiler_files = ":all",
    strip_files = ":empty",
    objcopy_files = ":empty",
    linker_files = ":all",
    dwp_files = ":empty",
    static_runtime_libs = [":empty"],
    dynamic_runtime_libs = [":empty"],
    supports_param_files = 0,
)

cc_toolchain_suite(
    name="emscripten",
    toolchains = {
        "asmjs": "asmjs_toolchain"
    }
)
