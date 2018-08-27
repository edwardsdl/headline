from flask import Flask


def create_app():
    app = Flask(__name__)

    @app.route('/')
    def index():
        return '', 200

    @app.route('/ping')
    def ping():
        return '', 200

    @app.route('/classification')
    def classification():
        return '', 200

    return app
