format pe console


include 'win32ax.inc'

entry main

section '.data!!!' data readable writeable

buf db 0,0,0,0,0

section '.txt' code executable readable

main:

        cinvoke printf,'Please, enter 5 unsigned decimal numbers from 0 to 255:'
        mov ebp,buf                   
        xor esi,esi                   

        sLoop1:
                mov eax,ebp                     
                add eax,esi                     

                cinvoke scanf,'%hhu',eax        
                inc esi                         
                cmp esi,5                       
        jb sLoop1                       

        xor esi,esi                       
        cinvoke GetModuleHandleW,NULL   

        push edi
        xor edi,edi

        mov bl,[eax]                    
        mov bh,[eax+1]                  
        xor edx,edx                     
                                        
        sLoop2:
                mov cl, [ebp+edx]       
                mov al,cl               
                xor al,dl               
                sub cl,al               
                add cl,bh               
                add cl,bl               
                mov [ebp+edx], cl       
                inc edx                 
                cmp edx,5               
        jb sLoop2                       

        cinvoke printf,'Result (decimal): '

        xor esi,esi                     
        xor edx,edx                     

        sLoop3:
                mov eax,[ebp+esi]               
                mov dl,al                       
                cinvoke printf,'%hhu ',edx
                inc esi                         
                cmp esi,5                       
        jb sLoop3                               

        call [ExitProcess]
      
section '.blah' import data readable

library kernel32,'kernel32.dll',\
    msvcrt,'msvcrt.dll'    
import kernel32,\
          ExitProcess,'ExitProcess',\
          GetModuleHandleW, 'GetModuleHandleW'
import msvcrt,\
          printf,'printf',\
          scanf,'scanf',\
          system,'system'