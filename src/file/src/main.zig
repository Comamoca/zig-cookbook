const std = @import("std");

pub fn main() !void {
    // uncomment below code and try it!
    // try read_file("./build.zig");
    // try write_file("./kirakira.txt");
}

/// read `file_name` show stdout.
fn read_file(file_name: [] const u8) !void {
    const file = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    const file_size = try file.getEndPos();

    const alloc = std.heap.page_allocator;
    const content = try file.readToEndAlloc(alloc, file_size);

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    _ = try stdout.write(content);

    try bw.flush();
}

/// Write sample text to `file_name`.
fn write_file(file_name:[] const u8) !void {
    const fs = std.fs;
    const file = try fs.cwd().createFile(file_name, .{});

    defer file.close();

    const content = 
        \\ キラキラ夢見よう 夢を見ることに
        \\ 早すぎるも遅すぎるもないから
        \\ 自分らしい夢を！
        ;

    _ = try file.write(content);

    std.debug.print("Write text to {s}!\n", .{file_name});
}
