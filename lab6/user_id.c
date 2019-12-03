#include <stdio.h>
#include <stdlib.h>

int main()
{

   	char * state[3] = {"DELETE","HIDE","USE"};
      FILE * fp;
      FILE * fd;
      fp = fopen("user_id.txt","w");
      fd = fopen("user_id_data.txt","w");
      int st;
   	//timestamp '2001-09-28 01:00:00'

   	for (int i = 0 ; i < 1000000 ; ++i)
   	{
   	  fprintf(fp,"%d\t",i+1); 
        fprintf(fp,"%d\t",rand()%4+1 );
        fprintf(fp,"%s\n",state[ st = rand()%3] );

        fprintf(fd,"%d\t",i+1); 
        fprintf(fd,"\'%d-%d-%d'\t", 
                  rand()%2333+1000,rand()%12+1,rand()%27+1); 
        fprintf(fd,"%d\t",rand()%2);
        fprintf(fd,"%d\t",rand()%100+17);
        int y;
         fprintf(fd,"\'%d-%d-%d %d:%d:%d\'\t", 
                     y=rand()%2333+1000,rand()%12+1,rand()%27+1,rand()%24,rand()%60,rand()%60); //time_creation

         
         if(!st) {fprintf(fd, "\'%d-%d-%d %d:%d:%d\'\t",   //time delete
            y+rand()%2333+1000,rand()%12+1,rand()%27+1,rand()%24,rand()%60,rand()%60
            );}
         else {fprintf(fd, "\\N\t" );}

         fprintf(fd,"\"%d.%d.%d.%d.%d\"\n",
                  rand()%1000,rand()%1000,rand()%1000,rand()%1000,rand()%1000);

   	}

      fclose(fp);
      fclose(fd);
}