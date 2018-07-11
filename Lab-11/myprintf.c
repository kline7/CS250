include <stdio.h>

extern int printx(int hex);
extern int printd(int inte);

int myprintf(const char * format,...)
{
        //obtain first arg                                                                                                                                                                                                                                                                                                                                                  
        int * arg = (int*)&format;
        arg++;
        int inte;
        //proccess the format string                                                                                                                                                                                                                                                                                                                                        
        char * form = (char*)format;
        while(*form)
        {
                //look for placeholders                                                                                                                                                                                                                                                                                                                                     
                if(*form == '%'){
                *form++;
                        //character                                                                                                                                                                                                                                                                                                                                         
                        if(*form == 'c'){
                                if(*arg){
                                        putchar(*arg++);
                                        }
                          *form++;
                                        }
                        //string                                                                                                                                                                                                                                                                                                                                            
                        if(*form == 's'){
                                if(*arg){
                                        char *s = (char*)*arg;
                                        while(*s){
                                        putchar(*s++);
                                                 }
                                        *arg++;
                                        }
                                *form++;
                                        }
                        //hexadecimal                                                                                                                                                                                                                                                                                                                                       
                        if(*form == 'x'){
                                inte = (int)*arg;
                                *arg++;
                                *form++;
                                printx(inte);
                                        }
                        //decimal                                                                                                                                                                                                                                                                                                                                           
                        if(*form == 'd'){
                                inte = (int)*arg;
                                *arg++;
                                *form++;
                                printd(inte);
                                        }
                         //%                                                                                                                                                                                                                                                                                                                                                
                        if(*form == '%'){
                        putchar('%');
                        *form++;
                                        }
                                }else{
                                        putchar(*form++);
                                }

        }
        return 0;
}
