import 'dart:math';


genRandomWalk(N, threshold){


	//crea las semillas generadoras de num aleatorios
	var rngx = new Random();
	var rngy = new Random();

	//crea el punto inicial del camino a generarse
	double x = rngx.nextDouble(); 
	double y = rngy.nextDouble(); 

	print("este es el origen x: $x, y: $y");
	//inicializa la lista de la serie de puntos del camino
	List walkPoints = [[x,y]];
	
	//añade N puntos al camino 
	while(N != 0){
		 x = rngx.nextDouble()*threshold; 
		 y = rngy.nextDouble()*threshold; 

		double distance = sqrt( pow(walkPoints.last[0] - x, 2) + pow(walkPoints.last[1] - y, 2) );
		print(distance)

		//verifica que la distancia entre puntos no sea mayor a 0.001
		if(distance <= threshold){
			walkPoints.add([walkPoints.last[0] + x, walkPoints.last[1] + y]);

			print(walkPoints);
			N--;
		}

	print("Iters restantes $N");

	}

	return walkPoints;

}

main(){

	int nPoints = 5;
	double maxDistance = 0.001;

	List walk = genRandomWalk(nPoints, maxDistance);
	print(walk);
}
