#!/bin/sh
# Prüft alle Stream-URLs aus index.html per HTTP-Abruf.
#
# Aufruf:  ./sender-check.sh [pfad/zur/index.html]
#
# Hinweis: Viele Streams der Öffentlich-Rechtlichen sind geo-gesperrt. Von außerhalb
# Deutschlands antworten sie mit 403 oder leiten auf eine internationale Variante um,
# ein 403 ist also erst aus Deutschland heraus aussagekräftig.

set -u

DATEI="${1:-$(dirname "$0")/index.html}"
[ -r "$DATEI" ] || { echo "Datei nicht gefunden: $DATEI" >&2; exit 1; }

# Senderliste aus index.html holen: alles zwischen "const SenderListe = {" und "};",
# Zeilenumbrüche entfernen, dann je Sender eine Zeile "'Name' : ...".
LISTE=$(sed -n '/const SenderListe = {/,/^[[:space:]]*};/p' "$DATEI" | tr -d '\n' | sed "s/'[^']*' : /\n&/g" | grep "^'")

FEHLER=0
# Kein Pipe in die Schleife, damit FEHLER nicht in einer Subshell verloren geht
while IFS= read -r zeile; do
	[ -n "$zeile" ] || continue
	name=${zeile#\'}; name=${name%%\'*}
	for url in $(printf '%s\n' "$zeile" | grep -oE "https?://[^']+"); do
		host=${url#*://}; host=${host%%/*}
		code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 15 \
			-A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/128 Safari/537.36' \
			"$url" 2>/dev/null || echo 000)

		case "$code" in
			200) status="OK" ;;
			403) status="403 – vermutlich Geo-Sperre (aus Deutschland prüfen)" ;;
			000) status="keine Verbindung" ;;
			*)   status="HTTP $code" ;;
		esac
		printf '%-14s %-58s %s\n' "$name" "$status" "$host"
		[ "$code" = "200" ] || FEHLER=1
	done
done <<LISTE_ENDE
$LISTE
LISTE_ENDE
exit $FEHLER
