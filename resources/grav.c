#define N 10
#define M_1 20
#define M_2 15
#define G 6.67e-11

int gravitational_force(float* x1, float* x2,float m1,float m2,float g, float* f){


	for(int i = 0; i < N; i++){
		f[i] = (g * m1 * m2) / ((x1[i]-x2[i])*(x1[i]-x2[i])); 	
	}
	return 0;
}

int main(){
	float x[N] = {1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5};
	float y[N] = {1.5, 2.5, 3.5, 4.5, 6.0, 8.0, 10.5, 11.0, 11.5, 12.0};
	float f[N] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

	return  gravitational_force(x,y,M_1,M_2,G,f);

}

