# Strings in ASM

## Descriere

Acest proiect reprezinta o tema de la cursul de *IOCLA* (Introducere in Organizarea
Calculatoarelor si Limbaje de Asamblare) si consta in diverse manipulari de
stringuri, implementarea unor algoritmi de criptare, **OTP**, **Caesar**, **Vigenere**,
a functiei **strstr** si a unei functii care face convseria din baza 2 in baza 16.
Mai multe detalii despre enunt se pot gasi [aici](https://ocw.cs.pub.ro/courses/iocla/teme/tema-2)


## Explicatii task-uri


### OTP - xor intre cheie si mesaj
	
Cum in ecx am lungimea lui plaintext, voi face o eticheta pe care o bag intr-un
loop. Mut intr-un registru (al) fiecare caracter in plaintext, pe rand si fac
xor cu caracterul corespunzator din key. Apoi introduc rezultatul in ciphertext.


### CAESER
	
Parcurg sirul din plaintext (esi) si verific caracterul curent daca este litera mare,
litera mica, sau alt caracter. Daca este litera (mare sau mica), adun la valoarea
acesteia, key si daca depaseste valoarea lui 'z', respectiv 'Z' scad 26 ('z' - 'a')
pana devine din nou litera (sa fie mai mic decat 'z' / 'Z'). Apoi pun caracterul
obtinut in ciphertext.


### VIGENERE
	
Parcurg sirul din plaintext si verific daca am litere, ca la caesar. Imi tin in 2
registri indici pentru plaintext si pentru key. Daca indicele de la key ajunge la
final, il resetez. Daca gasesc o litera, adun la ea caracterul corespunzator din
key si scad 'A', pentru a obtine indicele lui in alfabet. Daca obtin ceva care nu va
mai fi litera, scad 26 pana se obtine din nou. Apoi pun rezultatul in ciphertext.


### MY_STRSTR
	
Tin doi indici, pentru string si pentru eventualul substring. Parcurg string-ul si
bag in stiva indicele curent. Incep sa verific daca am 2 caractere egale in string
si substring pe cele 2 pozitii date de indici. Daca da, incrementez indicii si
continui verificarea. Cand indicele pentru substring este egal cu lungimea
substring-ului, ma opresc si returnez indecele pe salvat pe stiva. Daca intre timp
gasesc 2 caractere diferite, incrementez indicele lui haystack, resetez indicele
pentru needle si reiau procedeul.


### BIN_TO_HEX

Calculez lungimea sirului ce contine reprezentarea in hexa - ceil 
(lungime numar binar / 4). Pastrez si restul impartirii, pentru a sti cati biti
formeaza prima cifra din reprezentarea hexa. Parcurg gruparile de la sfarsit si
calculez valoarea in hexa a fiecarui grup de 4 biti alaturati. Am grija ca daca
rezultatul da mai mare sau egal cu 10, sa creez litera corespunzatoare. Cand termin
grupele, verific daca restul este nenul (am cativa biti care imi formeaza prima
cifra hexa) si ii parcurg de la stanga la dreapta sa o formez. Din nou o compar cu 
10 si rezultatul il voi pune in edx, registrul care imi va da reprezentarea hexa.


