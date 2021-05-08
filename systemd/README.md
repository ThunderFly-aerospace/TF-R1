## systemd scripts

Tato složka obsahuje užitečné system.d skripty pro automatické spouštění a správu jednotlivých programů/procesů. 


# Vytvoření odkazu na system.d skript
```
systemctl link <adresa .service souboru>
```

> adresa musí být absolutní. Jinak neproběhne vytvoření odkazu. 


# Upravení skriptu
Po jakémkoliv upravení skriptu je potreba spustit `systemctl daemon-reload`. Jinak nedojde k jehospuštění. 


# Automatické spouštění skriptu
```
systemctl enable <nazev sluzby>
```
