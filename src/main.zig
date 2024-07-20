const std = @import("std");
const net = std.net;
const Allocator = std.mem.Allocator;

/// So this thing should manage HTTP routes that we serve.
const Router = struct {
    // How in the world do we store routes?
};

/// This represents a connection to the server.
const Connection = struct {
    // Should a connection have a reference to a router?
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // TODO(DCut): Use resolveIp instead?
    const address = net.Address.parseIp("127.0.0.1", 80) catch unreachable;

    var server = try net.Address.listen(address, .{
        .kernel_backlog = 1024,
        .reuse_address = true,
    });

    // Just spin up another thread to handle polling for new connections on the socket
    const server_thread = try std.Thread.spawn(.{}, start_server, .{ allocator, &server });
    server_thread.detach();
}

fn start_server(allocator: Allocator, server: *net.Server) !void {
    defer server.deinit();

    while (true) {
        if (server.accept()) |conn| {
            // Create a connection?
        } else |err| {
            std.debug.print("Error: {any}", .{err});
        }
    }
}
