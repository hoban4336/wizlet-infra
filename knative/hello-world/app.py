import os
import sys
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    target = os.environ.get('TARGET', 'World')
    print("Hello from Flask!", file=sys.stdout, flush=True)  # stdout으로 로그 출력
    return 'Hello {}!\n'.format(target)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
