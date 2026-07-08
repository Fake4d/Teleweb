## Teleweb
Teleweb ist eine schlichte Internetseite, die den einfachen (Mobilgeräte-optimierten) Zugriff auf das Live-Programm der Öffentlich-Rechtlichen und eine Handvoll frei empfangbarer Privat- und Auslandssender ermöglicht. Die Bild-in-Bild-Funktion steht in Chrome, Edge und Safari (iPad/Mac) zur Verfügung. Der zuletzt gesehene Sender wird gemerkt und beim nächsten Besuch automatisch wieder gestartet.

### Demo
- Eine aktuelle Live-Version lässt sich auf [https://telemat.1mb.site/](https://telemat.1mb.site/) begutachten.

![](pics/screen-teleweb.png)

### Hotkeys
Steht eine Tastatur zur Verfügung, lässt sich zwischen den Sendern mit den Tasten „+/-“ zappen, die Taste „M“ schaltet den Ton ein bzw. stumm, die Taste „F“ startet und verlässt die Vollbildansicht, die Taste „S“ öffnet und schließt die Senderliste.

### Technik
Eine einzelne `index.html` ohne Build-Schritt: [Bootstrap 5](https://getbootstrap.com/) und [hls.js](https://github.com/video-dev/hls.js) kommen per CDN (versionsgepinnt, mit Subresource Integrity), die Bedienlogik ist reines JavaScript ohne weitere Abhängigkeiten. Die Senderliste steht als einfaches Objekt am Anfang der Datei und lässt sich dort direkt bearbeiten — weitere Streams findet man z.&nbsp;B. bei [iptv-org](https://iptv-org.github.io/).
