const std = @import("std");
const utils = @import("./utils.zig");

pub fn main() !void {
    var allocator = std.heap.page_allocator;

    const file_content = try utils.readFile(&allocator, "input.txt");
    defer allocator.free(file_content);

    try std.io.getStdOut().writer().print("File Contents:\n{*}\n", .{file_content});
}
