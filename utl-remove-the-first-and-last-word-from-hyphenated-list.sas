Remove the first and last word from hyphenated list                                                             
                                                                                                                
github                                                                                                          
https://tinyurl.com/y2vx2fr4                                                                                    
https://github.com/rogerjdeangelis/utl-remove-the-first-and-last-word-from-hyphenated-list                      
                                                                                                                
SAS forum                                                                                                       
https://tinyurl.com/yydlxqmu                                                                                    
https://communities.sas.com/t5/SAS-Programming/How-to-remove-the-prefix-and-suffix-at-one-step/m-p/557169       
                                                                                                                
Related github                                                                                                  
github                                                                                                          
https://tinyurl.com/ycqntnuz                                                                                    
https://github.com/rogerjdeangelis/utl-general-data-input-method-that-pops-words-out-of-a-sentence              
                                                                                                                
Solution #3 is the only single statement solution                                                               
                                                                                                                
Some solutions will not work with imbeded blanks.                                                               
                                                                                                                
FCMP rountine on end                                                                                            
                                                                                                                
    1.  Change hyphen to ' ' then call FCMP utl_pop                                                             
                                                                                                                
    2.  Call scan twice then substr.                                                                            
        Novinosrin                                                                                              
        https://communities.sas.com/t5/user/viewprofilepage/user-id/138205                                      
                                                                                                                
    3.  Substring with imbeeded find character function (NICE single statement - not the fastest)               
        Novinosrin                                                                                              
                                                                                                                
    4.  Looping countw catx scan                                                                                
        Novinosrin                                                                                              
                                                                                                                
    5.  In then else and regular expressions (prx). Only works for lists of 3 or 4 words.                       
        Jagadishkatam                                                                                           
        https://communities.sas.com/t5/user/viewprofilepage/user-id/12151                                       
                                                                                                                
    6.  Similar to #3 but uses findc only                                                                       
        Paul Dorfman                                                                                            
        sashole@bellsouth.net                                                                                   
                                                                                                                
    7.  Using tranword to set first and last word to blank                                                      
        Paul Dorfman                                                                                            
        sashole@bellsouth.net                                                                                   
                                                                                                                
    8.  Performance stats by Bart                                                                               
        Bartosz Jablonski                                                                                       
        yabwon@gmail.com                                                                                        
                                                                                                                
*_                   _                                                                                          
(_)_ __  _ __  _   _| |_                                                                                        
| | '_ \| '_ \| | | | __|                                                                                       
| | | | | |_) | |_| | |_                                                                                        
|_|_| |_| .__/ \__,_|\__|                                                                                       
        |_|                                                                                                     
;                                                                                                               
data have;                                                                                                      
input str $30.;                                                                                                 
cards4;                                                                                                         
Mr-Roger-Joe-DeAngelis-III                                                                                      
Mrs-Mary-Reed-Smith-Phd                                                                                         
Master-Harry-Jones-Pfc                                                                                          
Dr-Kildare-MD                                                                                                   
Miss-Mary-L-Marks-RN                                                                                            
;;;;                                                                                                            
run;quit;                                                                                                       
                                                                                                                
Up to 40 obs WORK.HAVE total obs=5                                                                              
                                                                                                                
Obs    STR                                                                                                      
                                                                                                                
 1     Mr-Roger-Joe-DeAngelis-III                                                                               
 2     Mrs-Mary-Reed-Smith-Phd                                                                                  
 3     Master-harry-mounty-Pfc                                                                                  
 4     Dr-Kildare-MD                                                                                            
 5     Miss-Mary-L-Marks-RN                                                                                     
                                                                                                                
*            _               _                                                                                  
  ___  _   _| |_ _ __  _   _| |_                                                                                
 / _ \| | | | __| '_ \| | | | __|                                                                               
| (_) | |_| | |_| |_) | |_| | |_                                                                                
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                               
                |_|                                                                                             
;                                                                                                               
Up to 40 obs WORK.WANT total obs=5                                                                              
                                                                                                                
Obs    WANT                   STR                                                                               
                                                                                                                
 1     Roger-Joe-DeAngelis    Mr-Roger-Joe-DeAngelis-III                                                        
 2     Mary-Reed-Smith        Mrs-Mary-Reed-Smith-Phd                                                           
 3     Harry-Jones            Master-Harry-Jones-Pfc                                                            
 4     Kildare                Dr-Kildare-MD                                                                     
 5     Mary-L-Marks           Miss-Mary-L-Marks-RN                                                              
                                                                                                                
*          _       _   _                                                                                        
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                        
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                       
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                       
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                       
                                                                                                                
;                                                                                                               
                                                                                                                
**************************************************                                                              
1.  Change hyphen to ' ' then call FCMP utl_pop                                                                 
**************************************************                                                              
                                                                                                                
* pops words off a list;                                                                                        
data want;                                                                                                      
  attrib word length=$32;                                                                                       
  set have;                                                                                                     
  words=translate(str,' ','-');                                                                                 
  call utl_pop(words,word,"first");                                                                             
  call utl_pop(words,word,"last" );                                                                             
run;quit;                                                                                                       
                                                                                                                
                                                                                                                
**************************************************                                                              
2.  Call scan twice then substr                                                                                 
**************************************************                                                              
                                                                                                                
data want;                                                                                                      
   set have;                                                                                                    
   call scan(str, 1, p, l,'-');                                                                                 
   call scan(str, -1, position, length,'-');                                                                    
   want=substr(str,l+2,position-(l+3));                                                                         
drop p: l:;                                                                                                     
run;                                                                                                            
                                                                                                                
****************************************************                                                            
3.  Substring with imbeded find character function                                                              
****************************************************                                                            
                                                                                                                
data want;                                                                                                      
  set have;                                                                                                     
  want=substr(str,index(str,'-')+1,findc(str,'-','B')- (index(str,'-')+1));                                     
run;                                                                                                            
                                                                                                                
**************************************************                                                              
4.  Looping countw catx scan                                                                                    
**************************************************                                                              
                                                                                                                
data want;                                                                                                      
  set have;                                                                                                     
  length want $30;                                                                                              
  do _n_=2 to countw(str,'-')-1;                                                                                
     want=catx('-',want,scan(str,_n_,'-'));                                                                     
  end;                                                                                                          
run;                                                                                                            
                                                                                                                
*************************************************************************************                           
5.  In then else and regular expressions (prx). Only works for lists of 3 or 4 words.                           
*************************************************************************************                           
                                                                                                                
data want;                                                                                                      
   set have;                                                                                                    
   if countw(str,'-')=4 then y=prxchange('s/(\w+\-)(\w+\-\w+)(\-\d+)/$2/',-1,str);                              
   else if countw(str,'-')=3 then y=prxchange('s/(\w+\-)(\w+)(\-\d+)/$2/',-1,str);                              
run;quit;                                                                                                       
                                                                                                                
                                                                                                                
**************************************                                                                          
6.  Similar to #3 but uses findc only                                                                           
**************************************                                                                          
                                                                                                                
data want;                                                                                                      
   set have;                                                                                                    
   want=substr (str, findc (str, "-") + 1, findc (str, "-", -32767) - findc (str, "-") - 1);                    
run;quit;                                                                                                       
                                                                                                                
                                                                                                                
**************************************                                                                          
7.  Using tranword to set first and last word to blank                                                          
**************************************                                                                          
                                                                                                                
data want;                                                                                                      
   set have;                                                                                                    
   str=translate(str,' ','-');                                                                                  
   want=tranwrd(str,scan(str,1)," ");                                                                           
   want=tranwrd(want,scan(str,-1)," ");                                                                         
run;quit;                                                                                                       
                                                                                                                
                                                                                                                
**************************************                                                                          
8. Performance stats by Bart                                                                                    
**************************************                                                                          
                                                                                                                
Paul,                                                                                                           
                                                                                                                
I was wondering if replacing -32767 with "B" modifier ("read backward")                                         
will give different results (in terms of speed) but it turns out the integer wins :-)                           
                                                                                                                
All the best                                                                                                    
Bart                                                                                                            
                                                                                                                
1    data have;                                                                                                 
2      input str $30.;                                                                                          
3      t=time();                                                                                                
4        hf = findc (str, "-");                                                                                 
5        do _N_ = 1 to 1e8;                                                                                     
6          hl = findc (str, "-", "B");                                                                          
7        end;                                                                                                   
8        str_want = substr (str, hf + 1, hl - hf - 1);                                                          
9      t=time()-t;                                                                                              
10     put t= @17 str=;                                                                                         
11   cards4;                                                                                                    
                                                                                                                
t=2.8870000839  str=Mr-Roger-Joe-DeAngelis-III                                                                  
t=3.0839998722  str=Mrs-Mary-Reed-Smith-Phd                                                                     
t=3.1440000534  str=Master-Harry-Jones-Pfc                                                                      
t=3.6960000992  str=Dr-Kildare-MD                                                                               
t=3.2019999027  str=Miss-Mary-L-Marks-RN                                                                        
NOTE: The data set WORK.HAVE has 5 observations and 5 variables.                                                
NOTE: DATA statement used (Total process time):                                                                 
      real time           16.01 seconds                                                                         
      user cpu time       16.01 seconds                                                                         
      system cpu time     0.04 seconds                                                                          
      memory              406.90k                                                                               
      OS Memory           18932.00k                                                                             
                                                                                                                
17   ;;;;                                                                                                       
18   run;quit;                                                                                                  
19                                                                                                              
20   data have;                                                                                                 
21     input str $30.;                                                                                          
22     t=time();                                                                                                
23       hf = findc (str, "-");                                                                                 
24       do _N_ = 1 to 1e8;                                                                                     
25         hl = findc (str, "-", -32767);                                                                       
26       end;                                                                                                   
27       str_want = substr (str, hf + 1, hl - hf - 1);                                                          
28     t=time()-t;                                                                                              
29     put t= @17 str=;                                                                                         
30   cards4;                                                                                                    
                                                                                                                
t=2.6990001202  str=Mr-Roger-Joe-DeAngelis-III                                                                  
t=2.996999979   str=Mrs-Mary-Reed-Smith-Phd                                                                     
t=2.9819998741  str=Master-Harry-Jones-Pfc                                                                      
t=3.5040001869  str=Dr-Kildare-MD                                                                               
t=3.1239998341  str=Miss-Mary-L-Marks-RN                                                                        
NOTE: The data set WORK.HAVE has 5 observations and 5 variables.                                                
NOTE: DATA statement used (Total process time):                                                                 
      real time           15.31 seconds                                                                         
      user cpu time       15.35 seconds                                                                         
      system cpu time     0.09 seconds                                                                          
      memory              406.90k                                                                               
      OS Memory           18932.00k                                                                             
                                                                                                                
                                                                                                                
 
 /*__                                                            
 / _| ___ _ __ ___  _ __    _ __   ___  _ __                    
| |_ / __| `_ ` _ \| `_ \  | `_ \ / _ \| `_ \                   
|  _| (__| | | | | | |_) | | |_) | (_) | |_) |                  
|_|  \___|_| |_| |_| .__/  | .__/ \___/| .__/                   
                   |_|     |_|         |_|                      
*/                                                              
                                                                
options cmplib=work.functions;                                  
proc fcmp outlib=work.functions.temp;                           
Subroutine utl_pop(string $,word $,action $);                   
    outargs word, string;                                       
    length word $4096;                                          
    select (upcase(action));                                    
      when ("LAST") do;                                         
        call scan(string,-1,_action,_length,' ');               
        word=substr(string,_action,_length);                    
        string=substr(string,1,_action-1);                      
      end;                                                      
                                                                
      when ("FIRST") do;                                        
        call scan(string,1,_action,_length,' ');                
        word=substr(string,_action,_length);                    
        string=substr(string,_action + _length);                
      end;                                                      
                                                                
      otherwise put "ERROR: Invalid action";                    
                                                                
    end;                                                        
endsub;                                                         
run;quit;                                                       

