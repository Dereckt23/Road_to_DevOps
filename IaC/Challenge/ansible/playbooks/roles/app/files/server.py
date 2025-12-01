# server.py
from http.server import HTTPServer, SimpleHTTPRequestHandler

server_address = ('0.0.0.0', 8080)
httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
print("App server running on port 5000...")
httpd.serve_forever()

