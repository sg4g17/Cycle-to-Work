from flask import Flask, flash, render_template,jsonify, request, redirect, url_for, session

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)