const std = @import("std");
const Allocator = std.mem.Allocator;

 pub fn build(b: *std.Build) !void {
    // Get user-supplied target and optimize functions
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Create compiled static library
    const yaml_cpp = b.addStaticLibrary(.{
        .name = "yaml-cpp-fortrajectum",
        .target = target,
        .optimize = optimize 
    });

    // Link libcpp (we need to do this to get the right headers)
    yaml_cpp.linkLibCpp();

    // Include headers
    yaml_cpp.addIncludePath(b.path("include"));

    // Add source files
    const cpp_flags = &.{"-std=c++11"};
    const cpp_src = &.{
        "src/binary.cpp",
        "src/convert.cpp",
        "src/depthguard.cpp",
        "src/directives.cpp",
        "src/emit.cpp",
        "src/emitfromevents.cpp",
        "src/emitter.cpp",
        "src/emitterstate.cpp",
        "src/emitterutils.cpp",
        "src/exceptions.cpp",
        "src/exp.cpp",
        "src/memory.cpp",
        "src/nodebuilder.cpp",
        "src/node.cpp",
        "src/node_data.cpp",
        "src/nodeevents.cpp",
        "src/null.cpp",
        "src/ostream_wrapper.cpp",
        "src/parse.cpp",
        "src/parser.cpp",
        "src/regex_yaml.cpp",
        "src/scanner.cpp",
        "src/scanscalar.cpp",
        "src/scantag.cpp",
        "src/scantoken.cpp",
        "src/simplekey.cpp",
        "src/singledocparser.cpp",
        "src/stream.cpp",
        "src/tag.cpp"
    };
    yaml_cpp.addCSourceFiles(.{ .files = cpp_src, .flags = cpp_flags });

    // Add headers to install directory
    yaml_cpp.installHeadersDirectory(b.path("include"), "", .{});

    // Install headers + binary
    b.installArtifact(yaml_cpp);
}
