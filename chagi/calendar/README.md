# Kalenderns tillägg

Redigera `events.json` på GitHub för att lägga till eller ändra händelser i Chagis kalender. Låt `version` vara `1`. Appen visar dessa tillsammans med händelser från ITF Sveriges kalendarium.

Varje händelse har `startDate` (ÅÅÅÅ-MM-DD), `country`, `city` och `title`. Använd `endDate` för en flerdagarstävling och `tentative: true` för ett preliminärt datum. `url` är valfri och öppnas när man trycker på tävlingsnamnet; den visas inte som en egen kolumn.

Filen publiceras på `https://f96nini.github.io/chagi-files/chagi/calendar/events.json`. Den är fristående från resultatens `manifest.json`. Efter en GitHub Pages-publicering hämtar appen den uppdaterade filen när kalendern öppnas; senast hämtade uppgifter finns kvar offline.
