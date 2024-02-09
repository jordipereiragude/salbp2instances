/* Simple code to subset alb instances and convert them to salbp-2. 
 * It also calculates the order strength of the input instance. 
 * The code is simple and handles all instances from the Otto set. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

typedef struct {
  unsigned n;
  unsigned m;
  char* prob_file;
  char* out_file;
  unsigned* t;
  unsigned** p;
  unsigned** f;
  double os;
} instance;

void read_file(instance* I) {
  FILE* in;
  char line[256];
  unsigned n;

  in = fopen(I->prob_file, "rt");
  while(1) {
    fgets(line, sizeof(line), in); 
    if(strstr(line,"<end>") != NULL) {
      break;
    }
    if(strstr(line,"<number of tasks>") != NULL) {
      fgets(line, sizeof(line), in); 
      n=atoi(line);
      assert(I->n<=n);
      I->t = (unsigned*)malloc((I->n+1)*sizeof(unsigned));
      I->p = (unsigned**)malloc((I->n+1)*sizeof(unsigned*));
      for(unsigned i=1;i<=I->n;i++) {
        I->p[i] = (unsigned*)malloc((I->n+1)*sizeof(unsigned));
      }
      I->f = (unsigned**)malloc((I->n+1)*sizeof(unsigned*));
      for(unsigned i=1;i<=I->n;i++) {
        I->f[i] = (unsigned*)malloc((I->n+1)*sizeof(unsigned));
      }
    }
    for(unsigned i=1;i<I->n;i++) {
      for(unsigned j=1;j<I->n;j++) {
        I->p[i][j] = 0;
        I->f[i][j] = 0;
      }
    }
    if(strstr(line,"<task times>") != NULL) {
      for(int i=1;i<=n;i++) {
        unsigned j,k;
        fgets(line, sizeof(line), in); 
        sscanf(line,"%d %d\n",&j,&k);
        assert(i==j);
        if(i<=I->n) {
          I->t[j] = k;
        }
      }
    }
    if(strstr(line,"<precedence relations>") != NULL) {
      while(1) {
        unsigned i,j;
        fgets(line, sizeof(line), in); 
        if(strlen(line)<3) {
          break;
        }
        sscanf(line,"%d,%d\n",&i,&j);
        assert(i<j);
        if(i<=I->n && j<=I->n) {
          I->p[i][j] = 1;
          I->f[i][j] = 1;
        }
      }
    }
  }
  fclose(in);
}

void transitive_closure(instance* I) {

  for(unsigned i=1;i<=I->n;i++) {
    for(unsigned j=i+1;j<=I->n;j++) {
      if(I->f[i][j]==1) {
        for(unsigned k=j+1;k<=I->n;k++) {
          if(I->f[j][k]==1 && I->f[i][k]==0) {
            I->f[i][k]=1;
          }
        }
      }
    }
  }
  unsigned n=0;
  for(unsigned i=1;i<=I->n;i++) {
    for(unsigned j=1;j<=I->n;j++) {
      if(I->f[i][j]==1) {
        n++;
      }
    }
  }
  I->os=(double)(n)/(double)((I->n*(I->n-1))/2);
}

void print_file(instance* I) {
  FILE* out;
  out=fopen(I->out_file, "wt");
  fprintf(out,"<number of tasks>\n%d\n\n",I->n);
  fprintf(out,"<number of stations>\n%d\n\n",I->m);
  fprintf(out,"<order strength>\n%.3f\n\n",I->os);
  fprintf(out,"<task times>\n");
  for(unsigned i=1;i<=I->n;i++) {
    fprintf(out,"%d %d\n",i,I->t[i]);
  }
  fprintf(out,"\n<precedence relations>\n");
  for(unsigned i=1;i<=I->n;i++) {
    for(unsigned j=1;j<=I->n;j++) {
      if(I->p[i][j]==1) {
        fprintf(out,"%d,%d\n",i,j);
      }
    }
  }
  fprintf(out,"\n<end>\n");
  fclose(out);
}

int main(int argc,char* argv[]) {
  instance I;

  if(argc < 5) {
    printf("Usage: %s <filename> <outfile> <tasks> <workstations>\n",argv[0]);
    return 0;
  }
  I.prob_file = (char*)malloc(strlen(argv[1])+1);
  snprintf(I.prob_file, strlen(argv[1])+1, "%s", argv[1]);
  I.out_file = (char*)malloc(strlen(argv[2])+1);
  snprintf(I.out_file, strlen(argv[2])+1, "%s", argv[2]);
  I.n = atoi(argv[3]);
  I.m = atoi(argv[4]);
  read_file(&I);
  transitive_closure(&I);
  print_file(&I);

  return 0;
}

