import 'dart:math';


class walk_and_fence{
	
	//variables importantes para generar la cerca
	List squareCenter = [];	
	double squareSide = 0.001;
	List squarebox = [];

	//variables importantes para generar el camino y guardarlo
	int N = 5;
	double threshold = 0.001; 
	List walk = [];

	walk_and_fence([N, threshold, squareSide]){

		//crea las semillas generadoras de num aleatorios
		var rngx = new Random();
		var rngy = new Random();

		double x = rngx.nextDouble(); 
		double y = rngy.nextDouble(); 

		print("Inicializando Instancia...");

		squareCenter = [x, y];
		print("este es el centro del cuadrado x: $x, y: $y");

		genRandomWalk();
		buildSqueare();
	}

	genRandomWalk(){

		//crea las semillas generadoras de num aleatorios
		var rngx = new Random();
		var rngy = new Random();

		//crea el punto inicial del camino a generarse
		double x = rngx.nextDouble(); 
		double y = rngy.nextDouble(); 

		print("este es el Inicio del camino x: $x, y: $y");
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

		//asigna a la variable de la clase
		walk = walkPoints; 
		return walk;
	}


	buildSqueare(){
		
		double x1 = squareCenter[0] - squareSide/2; //lado izq del cuadrado
		double x2 = squareCenter[0] + squareSide/2; //lado der del cuadrado
		double y1 = squareCenter[1] - squareSide/2; //lado inf del cuadrado
		double y2 = squareCenter[1] + squareSide/2; //lado sup del cuadrado
		
		squarebox = [[x1, x2], [y1, y2]];
		return squarebox;
	}




	checkInsideSquare(){
		
		for(int i = 0; i<walk.length; i++){
			double currPosx = walk[i][0];
			double currPosy = walk[i][1];

			if ( (currPosx < squarebox[0][1]) && (currPosx > squarebox[0][0]) && (currPosy > squarebox[1][0]) && (currPosy < squarebox[1][1]) ){
				return "Hay al menos un punto dentro de la cerca dada";
			}
		}

		return "No hay puntos del camino que estén dentro de la cerca dada";	
	}

}

main(){

	var obj = walk_and_fence();
	print(obj.checkInsideSquare());

}




