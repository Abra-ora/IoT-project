from flask import Flask, jsonify, request, render_template
import requests

app = Flask(__name__)

url = 'http://192.168.75.214:8080/api/'


@app.route('/temperature', methods=['GET'])
def get_temperature():
    temperature = requests.get(url+'temperature').json()
    return jsonify(temperature=temperature)


@app.route('/light', methods=['GET'])
def get_light():
    light = requests.get(url+'light').json()
    return jsonify(light=light)


@app.route('/led/autocontrole', methods=['POST'])
def autocontrole():
    value = request.get_json()
    requests.post(url+'controle?autoControle='+value['ledAutoControle'])
    return "OK"


@ app.route('/led/manuallcontrole', methods=['POST', 'GET'])
def led_on():
    value = request.get_json()
    requests.post(url+'light?autoControle='+value['LedManuallControle'])
    return "OK"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


# The above code creates a Flask application that listens for GET requests on the '/temperature' and '/light' routes.
# When a request is made, it sends a GET request to the ESP32 via the http client requests and reads the temperature or light sensor value respectively.
# The json() function is used to parse the json response from the ESP32.
# You will need to install the requests library and import it in your script.
# You will also need to upload the appropriate code to the ESP32 board that reads the sensor values, create a web server and make them available over the wifi network. The ESP32 should be configured to connect to a wifi network and the IP address of the ESP32 should be known.
# Please note that this is a basic example and you will need to adjust it to work with your specific setup, including the type of sensor you are using, how you are connecting to the ESP32, and any other requirements you may have.
# Also, you need to make sure that the ESP32 is connected to the same network as the Flask server and the IP address of the ESP32 is correct in the code.
