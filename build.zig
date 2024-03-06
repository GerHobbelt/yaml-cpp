const std = @import("std");
const Allocator = std.mem.Allocator;

 pub fn build(b: *std.Build) !void {
    // Initialise allocator
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();
    const alloc = arena_state.allocator();

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
    yaml_cpp.addIncludePath(.{ .path = "include/" });

    // Add source files
    const cpp_flags = &.{"-std=c++11"};
    const cpp_src = try list_cpp_src(alloc, "src/");
    yaml_cpp.addCSourceFiles(cpp_src.items, cpp_flags);

    // Create header library
    const yaml_hpp = b.addStaticLibrary(.{
        .name = "yaml-hpp-fortrajectum",
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
        .target = target,
        .optimize = optimize
    });
    //Empty c file to satisfy compiler
    yaml_hpp.installHeadersDirectory("include/", "yaml-cpp/");

    // Install compiled object & the headers
    b.installArtifact(yaml_cpp);
    b.installArtifact(yaml_hpp);
}


/// This function traverses the `src_dir` and produces an `ArrayList` of all
/// non-main source files in the `src_dir`.
fn list_cpp_src(alloc: Allocator, src_dir: []const u8) !std.ArrayList([]u8) {
    var source_files = std.ArrayList([]u8).init(alloc);
    var walker = (try std.fs.cwd().openIterableDir(src_dir, .{})).iterate();
    while (try walker.next()) |entry| {
        if (!std.mem.endsWith(u8, entry.name, ".cpp")) {
            continue;
        }
        var source_path = std.ArrayList(u8).init(alloc);
        try source_path.appendSlice(src_dir);
        try source_path.appendSlice(entry.name);
        try source_files.append(try source_path.toOwnedSlice());
    }
    return source_files;
}
