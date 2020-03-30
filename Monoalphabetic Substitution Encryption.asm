
org 100h

jmp start

;all variables used
msg1 db 0Dh,0Ah, "                -Monoalphabetic Substitution Encryption- $"
msg2 db 0Dh,0Ah, " Enter your message: $"
msg3 db 0Dh,0Ah, " The encrypted cipher text: $"
msg4 db 0Dh,0Ah, " The decrypted original message: $"
msg5 db 0Dh,0Ah, " If you want to repeatthe program kindly press 1,if not press enter: $"
msg6 db 0Dh,0Ah, " Thank you for using our program ^_^ $"


message db 27,?, 27 dup(' ')                                                       

choice db 1 dup (' ') 
;                       'abcdefghijklmnopqrstuvwxyz'
Table1 db 97 dup (' '), 'qwertyuiopasdfghjklzxcvbnm'
;                       '0------>10------->20---->26'
;                       '12345678901234567890123456'
Table2 db 97 dup (' '), 'kxvmcnophqrszyijadlegwbuft'




start:       
;display msg1
lea dx, msg1
mov ah, 09
int 21h
;display msg2
lea dx, msg2
mov ah, 09
int 21h

;input the msg
lea dx, message
mov ah, 0ah
int 21h

;puts $ at the end of the input to: 
;1. distinguish the end
;2. print it out afterwards	
mov bx,0
mov bl, message[1]
mov message[bx+2], '$'
		
		
; encryption:
lea bx, Table1
lea si, message

;making sure that the charcter entered is something between 'a' and 'z' 
next_letter1:
	cmp [si], '$'      ; end of msg ?
	je end_of_input_msg
	
	LODSB
	cmp al, 'a'
	jb  next_letter1 ;in case of undefined input
	cmp al, 'z'
	ja  next_letter1 ;in case of undefined input
	
encryption:
	xlat     ; encrypt using Table1  
	mov [si-1], al	
	jmp  next_letter1

end_of_input_msg:

;display msg3                
lea dx, msg3
mov ah, 09
int 21h
      
;displays the letters
lea dx, message+2
mov ah, 09
int 21h


; decryption:
lea bx, Table2
lea si, message

;making sure that the charcter entered is something between 'a' and 'z'
next_letter2:
	cmp [si], '$'      ; end of msg ?
	je end_of_encrypted_msg
	
	LODSB
	cmp al, 'a'
	jb  next_letter2  ;in case of undefined input
	cmp al, 'z'
	ja  next_letter2  ;in case of undefined input	

Decryption:	
	xlat     ; decrypt using Table2  
	mov [si-1], al
	jmp next_letter2

end_of_encrypted_msg:
                
;display msg4                
lea dx, msg4
mov ah, 09
int 21h

      
;displays the message
lea dx, message+2
mov ah, 09
int 21h

;Restart the program
;display msg5                
lea dx, msg5
mov ah, 09
int 21h
;Decision input
lea dx, choice
mov ah, 0ah
int 21h
lea si, choice 
LODSB
LODSB
LODSB
cmp al, '1'      ; if X=1,the program will restart
je start


;End of the program
;display msg6                
lea dx, msg6
mov ah, 09
int 21h
HLT   

end




