const std = @import("std");

// Declaratively construct the build graph that can be executed by an external runner.
pub fn build(b: *std.Build) void {
    // Standard target and optimization options
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Add executables for each day

    // Day 1
    const day01_exe = b.addExecutable(.{
        .name = "day01",
        .root_source_file = .{ .path = "src/day01.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(day01_exe);

    const day01_run_cmd = b.addRunArtifact(day01_exe);
    if (b.args) |args| {
        day01_run_cmd.addArgs(args);
    }

    const day01_step = b.step("run-day01", "Run Day 1");
    day01_step.dependOn(&day01_run_cmd.step);

    // Day 2
    const day02_exe = b.addExecutable(.{
        .name = "day02",
        .root_source_file = .{ .path = "src/day02.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(day02_exe);

    const day02_run_cmd = b.addRunArtifact(day02_exe);
    if (b.args) |args| {
        day02_run_cmd.addArgs(args);
    }

    const day02_step = b.step("run-day02", "Run Day 2");
    day02_step.dependOn(&day02_run_cmd.step);

    // Day 3
    const day03_exe = b.addExecutable(.{
        .name = "day03",
        .root_source_file = .{ .path = "src/day03.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(day03_exe);

    const day03_run_cmd = b.addRunArtifact(day03_exe);
    if (b.args) |args| {
        day03_run_cmd.addArgs(args);
    }

    const day03_step = b.step("run-day03", "Run Day 3");
    day03_step.dependOn(&day03_run_cmd.step);

    // General Testing Step (using main.zig as example)
    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
