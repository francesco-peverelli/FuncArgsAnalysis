
#define N 5

int f_loop(int* s1,int* s2,int* o1,int sc,int* sc1,int* sc2){
	
	int t_1[N];
	int t_2[N];
    int a = 103;
 
	for(int i = 0; i < N; i++){
		t_1[i] = s1[i]+s2[i];
		t_2[i] = t_1[i]*sc + sc;
		o1[i] = t_2[i]/o1[i];
		*sc2 = sc + (*sc1);
		*sc1 = sc*(*sc2);
	}

	for(int i = 0; i < N; i++){
		o1[i] = s1[i] + t_1[i];
        o1[i] = o1[i] / a;
    }
	return 0;
}

int main(){
	
	int a[] = { 1, 2, 3, 4, 5};
	int b[] = { 10, 20, 30, 40, 50};
	int c[N];
	int sc = 10;
	int sc2 = 3;
	int sc3 = 5;
	
	return f_loop(a,b,c,sc,&sc2,&sc3);
}
