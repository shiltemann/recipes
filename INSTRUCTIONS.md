Instructies voor het toevoegen van recepten aan de recepten site :D

Preview maken
#############

Open terminal (rode icoontje links boven op menu bar)

Type het volgende commando in om naar de folder met recepten te gaan:

```
cd recipes
```

Dan om preview van de website te maken, typ je in terminal:

```
make preview
```

open een browser en vul als url in:

```
localhost:4000/recipes/
```


Om een text editor te starten:

```
atom .
```
(let op de punt achteraan)



Recept maken
############
Tip: doe voor je begint een `make update` om site up-to-date te maken.

**Fotos**
- Fotos moeten in folder `recipes/images` en recepten zelf in "recipes/"
- In atom, rechter muisclick op folder `recipes/images` en kies
  *Show in File Manager* en kopieer je fotos naar die folder.

**Recepten**
- In Atom, rechermuisklik op `recipes` folder en kies *New File*
- Recepten moeten naam hebben als `YYYY-MM-DD-dishname.md`

- Voorbeeld recept in: `recipes/2222-01-01-example.md` met ook uitleg
- Let goed op de spaties, aantal spaties vooraan maakt uit!
- Tip: gebruik geen dubbele punten in je instructies!
- Je mag zelf zoveel categorieen toevoegen als je wilt

Tip: in Atom, file saven: `CTRL+S`


Recept Uploaden
###############

Als je blij bent met het recept kun je het uploaden, dit kan op 2 manieren:

1. **Via de browser**

   - Ga naar: github.com/shiltemann/recipes

   Fotos:
   - Ga naar `recipes/images/` en daar *Upload Files* en upload je fotos
   - Onderaan, klik op bovenste optie "commit changes"
   - (In Oktober, klik op tweede optie, "propose changes" om een shirt te
     verdienen ;))

   Recept:
   - Ga nu naar de `recipes/` folder en *New file*
   - Geef de file een naam als YYYY-MM-DD-dishname.md
   - Kopieer je recept in de file
   - Onderaan, klik op een van de opties om te uploaden


2. **Via computer**

   - type de volgend commandos:

     git add recipes/images/[foto naam]
     git add recipes/[recept file naam]
     git commit -m "added recipe for blabla"
     git push

     (Nu vraagt hij je om je username/password)

  - Als je deze manier fijn vindt, dan altijd voordat je begint met je     recept toe te voegen, eerst de site updaten: `make update`


Site updaten
############
Als andere mensen recepten hebben toegevoegd en je wilt die in je preview zien moet je eerst de site updaten:

```
make update
```

Doe dit altijd als je via de computer je recept wil gaan uploaden!

Eet smakelijk!
