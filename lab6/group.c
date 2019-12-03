
#include <stdio.h>
#include <stdlib.h>

int main()
{

   	char * GOOD_WORD[10] = {"GOOD","BAD","USEFUL","SMART","SLIGHTY","HIGHER","CORRECT","FUNNY","STUPID","CLOSELY"};
      char * PREFIX   [7]  = {"VERY VERY","NOT","VERY","ABSOLUTLY","100%","I THINK"};
      char * POSTFIX  [25]   = { "You\'re doing great!","That's better than ever!","Way to go!","Good job!"
                               "Magnificent!","Fantastic","Keep it up!","Superb!","Well done!","Excellent!"
                               "Perfect!","Brilliant!","That's perfectly correct","Yes, you\'ve got it",
                               "That\'s just what I was looking for.","You really figured it out!",
                               "I like that!","Very good!","Good for you!","Great you are!","That\'s right.",
                               "That\'s nice.","That\'s it.","Exactly"};
      char * state[3] = {"DELETE","HIDE","USE"};
      FILE * fp;
      FILE * fd;
      fp = fopen("group.txt","w");
      fd = fopen("group_data.txt","w");
      int st;
      //timestamp '2001-09-28 01:00:00'

   	for (int i = 0 ; i < 1000 ; ++i)
   	{
   	  fprintf(fp,"%d\t",i+1); //id  
        fprintf(fp,"%s\t",state[ st = rand()%3] ); //state
        fprintf(fp,"%d\t",rand()%5+1 );//rate 	
        fprintf(fp,"%d\n",rand()%4+1 );//role

        fprintf(fd,"%d\t",i+1);
        fprintf(fd,"%d\t",rand()%1000000);
        int y;
         fprintf(fd,"\'%d-%d-%d %d:%d:%d\'\t", 
                     y=rand()%2333+1000,rand()%12+1,rand()%27+1,rand()%24,rand()%60,rand()%60); //time_creation

         
         if(!st) {fprintf(fd, "\'%d-%d-%d %d:%d:%d\'\t",   //time delete
            y+rand()%3333,rand()%12+1,rand()%27+1,rand()%24,rand()%60,rand()%60
            );}
         else {fprintf(fd, "\\N\t" );}

         fprintf(fd, "\"*%ld**%s***%s****%s*****\"\n",  //text
         random(),PREFIX[rand()%6],GOOD_WORD[ (rand() % 10) ], POSTFIX[(rand() % 24)] );

   	}
   	
      fclose(fp);
      fclose(fd);
}