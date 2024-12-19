import requests
import json

response = requests.get("https://api.github.com/meta")
data = response.json()
print(json.dumps({"ip_ranges": data["actions"]}))
