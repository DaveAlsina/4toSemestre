import 'dart:math';


genRandomWalk(int N, double threshold){


	//crea las semillas generadoras de num aleatorios
	var rngx = new Random();
	var rngy = new Random();

	//crea el punto inicial del camino a generarse
	double x = rngx.nextDouble(); 
	double y = rngy.nextDouble(); 

	print("este es el origen x: $x, y: $y");
	//inicializa la lista de la serie de puntos del camino
	List walkPoints = [[x,y]];
	N--;
	
	//añade N puntos al camino 
	while(N != 0){
		
		//genera los nuevos puntos de la caminata partiendo de la posición anterior
		x = rngx.nextDouble()*threshold + walkPoints.last[0] ; 
		y = rngy.nextDouble()*threshold + walkPoints.last[1]; 

		walkPoints.add([x,  y]);
		N--;

	}

	return walkPoints;
}


buildSqueare(List point, double side){
	
	double x1 = point[0] - side/2; //lado izq del cuadrado
	double x2 = point[0] + side/2; //lado der del cuadrado
	double y1 = point[1] - side/2; //lado inf del cuadrado
	double y2 = point[1] + side/2; //lado sup del cuadrado
	
	return [[x1, x2], [y1, y2]];
}

checkInsideSquare(List squarebox, List walk){
	
	for(int i = 0; i<walk.length; i++){
		double currPosx = walk[i][0];
		double currPosy = walk[i][1];

		if ( (currPosx < squarebox[0][1]) && (currPosx > squarebox[0][0]) && (currPosy > squarebox[1][0]) && (currPosy < squarebox[1][1]) ){
			return "Hay al menos un punto dentro de la cerca dada";
		}
	}

	return "No hay puntos del camino que estén dentro de la cerca dada";	
}

main(){

	int nPoints = 5;
	double maxDistance = 0.001;

	List walk = genRandomWalk(nPoints, maxDistance);
	print("Los puntos del camino son: ");
	print(walk);


	List squarebox = buildSqueare([0,0], maxDistance);
	print("Los puntos de la caja cuadrada son de la forma [[x1,x2], [y1,y2]] y tiene los siguientes valores:");
	print(squarebox);

	
	print(checkInsideSquare(squarebox, walk));
}




