<h1>
    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYZAWAOWyZH9kRy-hzc7TJGO86vtx4cGcDwnlYv-MsNboxH4NSOCFdLPY&s" alt="MS SQL Server" width="70" align="left" />
    &nbsp;&nbsp;SQL Server Scripts</h1>


## 🇸🇰 Slovenčina

Ukážky mojich `SELECT` dotazov z reálnych projektov použitých v **MS SQL Server Management Studio (SSMS)**.

### 📂 Obsah repozitára
* **[ukazky_selektov.sql](./ukazky_selektov.sql)** – zbierka praktických SQL dopytov z dvoch oblastí:
  * **Realitný portál (predaj bytov):** Základné `SELECT` dotazy, spájanie tabuliek pomocou `INNER JOIN` a úprava záznamov (`UPDATE`).
  * **Testovanie informačného systému (colná / logistická doména):**
    * Filtrovanie platných záznamov na základe časových intervalov (`GETDATE()`, `NULL` hodnoty) a operátora `IN`.
    * Práca s premennými (`DECLARE`) na postupné dohľadávanie prepojených ID naprieč viacerými tabuľkami.
    * Dekompresia a pretypovanie komprimovaných binárnych dát do čitateľného XML formátu pomocou `CAST(DECOMPRESS(...) AS XML)`.
    * Spájanie tabuliek cez `JOIN` s kontrolou logického zmazania záznamu (`IS NULL`).

> *Poznámka: Názvy tabuliek, stĺpcov a identifikátorov boli z bezpečnostných dôvodov anonymizované.*

---

## 🇩🇪 Deutsch

Beispiele meiner `SELECT`-Abfragen aus realen Projekten, verwendet im **MS SQL Server Management Studio (SSMS)**.

### 📂 Inhalt des Repositories
* **[select_abfragen_beispiele.sql](./select_abfragen_beispiele.sql)** – Sammlung praktischer SQL-Abfragen aus zwei Bereichen:
  * **Immobilien-Webseite (Wohnungsverkauf):** Grundlegende `SELECT`-Abfragen, Tabellenverknüpfungen mit `INNER JOIN` sowie Datenaktualisierung (`UPDATE`).
  * **Testen eines Informationssystems (Zoll- / Logistikbereich):**
    * Filtern gültiger Datensätze anhand von Zeitintervallen (`GETDATE()`, `NULL`-Werte) und dem `IN`-Operator.
    * Verwendung von Variablen (`DECLARE`) zur schrittweisen Ermittlung verknüpfter IDs über mehrere Tabellen hinweg.
    * Dekomprimierung und Konvertierung komprimierter Binärdaten in ein lesbares XML-Format mittels `CAST(DECOMPRESS(...) AS XML)`.
    * Tabellenverknüpfungen (`JOIN`) inklusive Prüfung auf logisch gelöschte Datensätze (`IS NULL`).

> *Hinweis: Die Namen der Tabellen, Spalten und Identifikatoren wurden aus Sicherheitsgründen absichtlich geändert.*
