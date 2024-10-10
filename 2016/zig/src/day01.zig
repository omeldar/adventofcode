const std = @import("std");
const math = std.math;

const Direction = enum { North, East, South, West };

const Position = struct {
    x: i32,
    y: i32,
    facing: Direction,

    pub fn updatePosition(self: *Position, turn: u8, distance: i32) void {
        switch (turn) {
            0 => {
                self.facing = switch (self.facing) {
                    .North => Direction.West,
                    .West => Direction.South,
                    .South => Direction.East,
                    .East => Direction.North,
                };
            },
            1 => {
                self.facing = switch (self.facing) {
                    .North => Direction.East,
                    .East => Direction.South,
                    .South => Direction.West,
                    .West => Direction.North,
                };
            },
            else => {},
        }

        //Move
        switch (self.facing) {
            .North => self.y += distance,
            .East => self.x += distance,
            .South => self.y -= distance,
            .West => self.x -= distance,
        }
    }
};

pub fn main() !void {
    const filename = "input.txt";
    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const read_buf = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(read_buf);

    var it = std.mem.split(u8, read_buf, ", ");

    var position = Position{
        .x = 0,
        .y = 0,
        .facing = Direction.North,
    };

    while (it.next()) |instruction| {
        const direction = instruction[0];

        const distance = std.fmt.parseInt(i32, instruction[1..], 10) catch {
            std.debug.print("Failed to parse distance\n", .{});
            return;
        };

        var turn: u8 = 0; // Mutable variable to store turn value
        switch (direction) {
            'R' => turn = 1,
            'L' => turn = 0,
            else => {
                std.debug.print("Invalid direction {}\n", .{direction});
                continue;
            },
        }

        position.updatePosition(turn, distance);
    }

    std.debug.print("Final Position: ({}, {})\n", .{ position.x, position.y });

    const absx = try std.math.absInt(position.x);
    const absy = try std.math.absInt(position.y);

    std.debug.print("You are {} blocks away from the target", .{absx + absy});
}
