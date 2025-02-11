# 📄 Dokumentacja Bazy Danych `wiekszabaza`

## 📌 Opis ogólny
Baza danych `wiekszabaza` jest relacyjną bazą danych służącą do zarządzania klubami jeździeckimi, ich klientami, pracownikami, końmi oraz powiązanymi danymi, takimi jak adresy, wynagrodzenia czy znajomość języków obcych.

---

## 📌 Struktura bazy
Baza danych składa się z **24 tabel**, podzielonych na kilka głównych kategorii:

### 📍 Lokalizacja
- `adresy` – przechowuje dane adresowe.

### 📍 Instytucje
- `kluby_jezdzieckie` – kluby jeździeckie.
- `szkoly` – szkoły współpracujące z klubami.
- `firmy` – firmy działające jako klienci.

### 📍 Klienci
- `klienci` – dane kontaktowe klientów.
- `osoby_prywatne` – klienci będący osobami prywatnymi.
- `karty_czlonkowskie` – karty członkowskie przypisane do klientów i koni.

### 📍 Zwierzęta
- `konie` – lista koni dostępnych w klubach.
- `stajnie` – stajnie, w których przebywają konie.

### 📍 Pracownicy
- `pracownicy` – dane wszystkich pracowników klubów.
- `weterynarze` – pracownicy posiadający kwalifikacje weterynaryjne.
- `sprzedawcy` – pracownicy zajmujący się sprzedażą w klubach.

### 📍 Języki obce
- `jezyki_obce` – lista języków.
- `znajomosc_jezykow_obcych` – powiązanie języków obcych z pracownikami.

### 📍 Finanse
- `wynagrodzenia` – dane o wynagrodzeniach pracowników.

---

## 📌 Kluczowe relacje między tabelami
- **Każdy klub jeździecki (`kluby_jezdzieckie`)** ma przypisany **adres (`adresy`)**.
- **Każdy klub może mieć wielu klientów (`klienci`)**, a klienci mogą być zarówno **osobami prywatnymi (`osoby_prywatne`)**, jak i **firmami (`firmy`)**.
- **Każdy koń (`konie`)** jest przypisany do jednej stajni (`stajnie`) oraz jednego klubu (`kluby_jezdzieckie`).
- **Każdy pracownik (`pracownicy`)** jest przypisany do jednego klubu (`kluby_jezdzieckie`), może także pracować w konkretnej stajni (`stajnie`).
- **Każdy pracownik może być weterynarzem (`weterynarze`) lub sprzedawcą (`sprzedawcy`)**.
- **Sprzedawcy mogą znać różne języki obce (`znajomosc_jezykow_obcych`)**.
- **Każdy klient może posiadać kartę członkowską (`karty_czlonkowskie`), która określa, którego konia ujeżdża**.
- **Każdy pracownik może mieć przypisane wynagrodzenie (`wynagrodzenia`)**.

---

## 📌 Kluczowe pola i ich znaczenie

| **Tabela** | **Kolumna** | **Opis** |
|------------|------------|----------|
| `adresy` | `ID_adresu` | Unikalny identyfikator adresu |
| `kluby_jezdzieckie` | `ID_klubu` | Unikalny identyfikator klubu |
| `klienci` | `ID_klienta` | Unikalny identyfikator klienta |
| `konie` | `ID_konia` | Unikalny identyfikator konia |
| `pracownicy` | `ID_pracownika` | Unikalny identyfikator pracownika |
| `wynagrodzenia` | `Pensja_podstawowa` | Podstawowa kwota wynagrodzenia |

---

## 📌 Potencjalne zastosowania bazy
- **Zarządzanie danymi klubów jeździeckich i ich klientami**.
- **Monitorowanie przypisania koni do stajni i klientów**.
- **Obsługa pracowników, ich wynagrodzeń oraz znajomości języków obcych**.
- **Rejestracja relacji między firmami, szkołami i klientami**.

---

Jeśli potrzebujesz jakichkolwiek zmian lub dodatkowych informacji – daj mi znać! 😊
