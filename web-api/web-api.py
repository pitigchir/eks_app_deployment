from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/quotes', methods=['GET'])
def get_quote():
  data = "Today will be the best day in your life"
  return jsonify({'Quote for today': data})
        
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
