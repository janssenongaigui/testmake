"""
This is the APP to be operationalized.
"""
# from flask import Flask
# # set the project root directory as the static folder, you can set others.
# app = Flask(__name__, static_url_path='')

# @app.route('/')
# def root():
#     return app.send_static_file('index.html')
    
from flask import Flask, send_from_directory
import os

app = Flask(__name__, static_url_path='')

@app.route('/')
def serve_index():
    return app.send_static_file('index.html')

@app.route('/favicon.ico') 
def favicon(): 
    return send_from_directory(os.path.join(app.root_path, 'static'), 'favicon.ico', mimetype='image/vnd.microsoft.icon')

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
