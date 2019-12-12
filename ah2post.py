from bs4 import BeautifulSoup
import sys
import requests

url = sys.argv[1]
data = requests.get(url).text
soup = BeautifulSoup(data, 'lxml')

ingredients = soup.find_all("a", {'class': 'js-ingredient'})
ingredients = [x.attrs['data-default-label'] for x in ingredients]


title = soup.find('title').text
title = title[:title.index(' - Recept - ')]
servings = soup.find('a', {'class': 'servings'}).text

prep_time = soup.find('li', {'class': 'cooking-time'}).find_all('li')
prep_time = ', '.join([x.text for x in prep_time])

ingredients = '\n'.join(['    * %s' % i for i in ingredients])

directions = soup.find('section', {'class': 'preparation'}).find('ol').find_all('li')
directions = [x.text for x in directions]
directions = [f'    {idx + 1}. {content}' for idx, content in enumerate(directions)]
directions = '\n'.join(directions)


tags = soup.find('section', {'class': 'tags'}).find_all('a')
tags = [x.text.strip() for x in tags]
tags = [f'  - {x}' for x in tags]
tags = '\n'.join(tags)

image = soup.find('li', {'class': 'responsive-image'}).attrs['data-phone-src']

q = f"""---
date: 2019-11-04
title: {title}
person: Albert Heijn
categories:
{tags}
image: {image}
recipe:
  servings: {servings}
  prep: {prep_time}
  cook: MISSING
  ingredients: |-
{ingredients}
  directions: |-
{directions}

---

Based off of an [Appie recipe]({url})
      """

print(q)
