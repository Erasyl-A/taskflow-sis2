from http.server import BaseHTTPRequestHandler, HTTPServer


class TaskFlowHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(b"TaskFlow service is running!\n")


server = HTTPServer(("127.0.0.1", 8080), TaskFlowHandler)

print("TaskFlow service started on port 8080")
server.serve_forever()
