import requests
import json

page = 0

schools = []

for page_number in range(66):
print("---")
page = page_number + 1
url = f"https://api.data.gov/ed/collegescorecard/v1/schools.json?per_page=100&page={page}&fields=school.name,id,fed_sch_cd,school.city,school.state,school.title_iv.eligibility_type,school.title_iv.approval_date,school.accreditor,school.ownership,2019.student.size,2019.student.retention_rate.four_year.full_time,2019.student.retention_rate.lt_four_year.full_time&api_key=PfPxL840kApgSjESx7qcxltfr7J2RE0eoxcffOjK"
print("Requesting", url)
response = requests.get(url)
data = response.json()
schools.extend(data['results'])
print(url)

json_object = json.dumps(schools, indent=4)

with open('data.json', 'w', encoding='utf-8') as outfile:
outfile.write(json_object)
