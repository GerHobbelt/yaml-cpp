const std = @import("std");
const Allocator = std.mem.Allocator;

 pub fn build(b: *std.Build) !void {
    // Initialise allocator
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();
    const alloc = arena_state.allocator();

    const root_dir = b.build_root.handle;

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
    yaml_cpp.addIncludePath(.{ .path = "include" });

    // Add source files
    const cpp_flags = &.{"-std=c++11"};
    const cpp_src = try list_cpp_src(alloc, try root_dir.openDir("src", .{}));
    yaml_cpp.addCSourceFiles(cpp_src.items, cpp_flags);

    // Add headers to install directory
    yaml_cpp.installHeadersDirectory("include", "");

    // Install headers + binary
    b.installArtifact(yaml_cpp);
}

/// This function traverses the `src_dir` and produces an `ArrayList` of all
/// non-main source files in the `src_dir`.
fn list_cpp_src(alloc: Allocator, src_dir: std.fs.Dir) !std.ArrayList([]u8) {
    var source_files = std.ArrayList([]u8).init(alloc);
    var walker = (try src_dir.openIterableDir(".", .{})).iterate();
    while (try walker.next()) |entry| {
        if (!std.mem.endsWith(u8, entry.name, ".cpp")) {
            continue;
        }
        try source_files.append(try src_dir.realpathAlloc(alloc, entry.name));
    }
    return source_files;
}
