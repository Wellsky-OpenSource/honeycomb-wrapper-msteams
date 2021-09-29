import requests
import json
import os

URL = os.environ.get('URL','Specified environment variable is not set')

def honeycomb_trigger(request):
    request_json = request.get_json()
    if "name" in request_json:
        title = request_json["name"]
        text = (
            request_json["trigger_description"]
            + "<br/> Current Status:"
            + request_json["status"]
            + "<br/>[Link to the Trigger]("
            + request_json["trigger_url"]
            + ")"
        )
        data = {"title": title, "text": text}
        r = requests.post(url=URL, data=json.dumps(data))
        if r.text == "1":
            return {"result": "Successfully Sent the Notification to MS Teams Channel"}
        else:
            return {
                "result": "Trigger to Application Failed Kindly Check Teams Channel URL"
            }
    else:
        return {
            "result": "Invalid JSON input kindly correct the Input as per MS-Teams Format"
        }